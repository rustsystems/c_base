// Copyright 2009 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// Garbage collector: marking and scanning

package runtime

import (
	"internal/goarch"
	"internal/goexperiment"
	"runtime/internal/atomic"
	"runtime/internal/sys"
	"unsafe"
)

const (
	fixedRootFinalizers = iota
	fixedRootFreeGStacks
	fixedRootCount

	// rootBlockBytes is the number of bytes to scan per data or
	// BSS root.
	rootBlockBytes = 256 << 10

	// maxObletBytes is the maximum bytes of an object to scan at
	// once. Larger objects will be split up into "oblets" of at
	// most this size. Since we can scan 1–2 MB/ms, 128 KB bounds
	// scan preemption at ~100 µs.
	//
	// This must be > _MaxSmallSize so that the object base is the
	// span base.
	maxObletBytes = 128 << 10

	// drainCheckThreshold specifies how many units of work to do
	// between self-preemption checks in gcDrain. Assuming a scan
	// rate of 1 MB/ms, this is ~100 µs. Lower values have higher
	// overhead in the scan loop (the scheduler check may perform
	// a syscall, so its overhead is nontrivial). Higher values
	// make the system less responsive to incoming work.
	drainCheckThreshold = 100000

	// pagesPerSpanRoot indicates how many pages to scan from a span root
	// at a time. Used by special root marking.
	//
	// Higher values improve throughput by increasing locality, but
	// increase the minimum latency of a marking operation.
	//
	// Must be a multiple of the pageInUse bitmap element size and
	// must also evenly divide pagesPerArena.
	pagesPerSpanRoot = 512
)

// gcMarkRootPrepare queues root scanning jobs (stacks, globals, and
// some miscellany) and initializes scanning-related state.
//
// The world must be stopped.
func gcMarkRootPrepare() {
	assertWorldStopped()

	work.nDataRoots = 0

	// Only scan globals once per cycle; preferably concurrently.
	roots := gcRoots
	for roots != nil {
		work.nDataRoots++
		roots = roots.next
	}

	// Scan span roots for finalizer specials.
	//
	// We depend on addfinalizer to mark objects that get
	// finalizers after root marking.
	//
	// We're going to scan the whole heap (that was available at the time the
	// mark phase started, i.e. markArenas) for in-use spans which have specials.
	//
	// Break up the work into arenas, and further into chunks.
	//
	// Snapshot allArenas as markArenas. This snapshot is safe because allArenas
	// is append-only.
	mheap_.markArenas = mheap_.allArenas[:len(mheap_.allArenas):len(mheap_.allArenas)]
	work.nSpanRoots = len(mheap_.markArenas) * (pagesPerArena / pagesPerSpanRoot)

	// Scan stacks.
	//
	// Gs may be created after this point, but it's okay that we
	// ignore them because they begin life without any roots, so
	// there's nothing to scan, and any roots they create during
	// the concurrent phase will be caught by the write barrier.
	work.stackRoots = allGsSnapshot()
	work.nStackRoots = len(work.stackRoots)

	work.markrootNext = 0
	work.markrootJobs = uint32(fixedRootCount + work.nDataRoots + work.nSpanRoots + work.nStackRoots)

	// Calculate base indexes of each root type
	work.baseData = uint32(fixedRootCount)
	work.baseSpans = work.baseData + uint32(work.nDataRoots)
	work.baseStacks = work.baseSpans + uint32(work.nSpanRoots)
	work.baseEnd = work.baseStacks + uint32(work.nStackRoots)
}

// gcMarkRootCheck checks that all roots have been scanned. It is
// purely for debugging.
func gcMarkRootCheck() {
	if work.markrootNext < work.markrootJobs {
		print(work.markrootNext, " of ", work.markrootJobs, " markroot jobs done\n")
		throw("left over markroot jobs")
	}

	// Check that stacks have been scanned.
	//
	// We only check the first nStackRoots Gs that we should have scanned.
	// Since we don't care about newer Gs (see comment in
	// gcMarkRootPrepare), no locking is required.
	i := 0
	forEachGRace(func(gp *g) {
		if i >= work.nStackRoots {
			return
		}

		if !gp.gcscandone {
			println("gp", gp, "goid", gp.goid,
				"status", readgstatus(gp),
				"gcscandone", gp.gcscandone)
			throw("scan missed a g")
		}

		i++
	})
}

// ptrmask for an allocation containing a single pointer.
var oneptrmask = [...]uint8{1}

// markroot scans the i'th root.
//
// Preemption must be disabled (because this uses a gcWork).
//
// Returns the amount of GC work credit produced by the operation.
// If flushBgCredit is true, then that credit is also flushed
// to the background credit pool.
//
// nowritebarrier is only advisory here.
//
//go:nowritebarrier
func markroot(gcw *gcWork, i uint32, flushBgCredit bool) int64 {
	// Note: if you add a case here, please also update heapdump.go:dumproots.
	var workDone int64
	var workCounter *atomic.Int64
	switch {
	case work.baseData <= i && i < work.baseSpans:
		workCounter = &gcController.globalsScanWork
		roots := gcRoots
		c := work.baseData
		for roots != nil {
			if i == c {
				workDone += markrootBlock(roots, gcw)
				break
			}
			roots = roots.next
			c++
		}

	case i == fixedRootFinalizers:
		for fb := allfin; fb != nil; fb = fb.alllink {
			cnt := uintptr(atomic.Load(&fb.cnt))
			scanblock(uintptr(unsafe.Pointer(&fb.fin[0])), cnt*unsafe.Sizeof(fb.fin[0]), &finptrmask[0], gcw)
		}

	case i == fixedRootFreeGStacks:
		// FIXME: We don't do this for gccgo.

	case work.baseSpans <= i && i < work.baseStacks:
		// mark mspan.specials
		markrootSpans(gcw, int(i-work.baseSpans))

	default:
		// the rest is scanning goroutine stacks
		workCounter = &gcController.stackScanWork
		if i < work.baseStacks || work.baseEnd <= i {
			printlock()
			print("runtime: markroot index ", i, " not in stack roots range [", work.baseStacks, ", ", work.baseEnd, ")\n")
			throw("markroot: bad index")
		}
		gp := work.stackRoots[i-work.baseStacks]

		// remember when we've first observed the G blocked
		// needed only to output in traceback
		status := readgstatus(gp) // We are not in a scan state
		if (status == _Gwaiting || status == _Gsyscall) && gp.waitsince == 0 {
			gp.waitsince = work.tstart
		}

		// scanstack must be done on the system stack in case
		// we're trying to scan our own stack.
		systemstack(func() {
			// If this is a self-scan, put the user G in
			// _Gwaiting to prevent self-deadlock. It may
			// already be in _Gwaiting if this is a mark
			// worker or we're in mark termination.
			userG := getg().m.curg
			selfScan := gp == userG && readgstatus(userG) == _Grunning
			if selfScan {
				casgstatus(userG, _Grunning, _Gwaiting)
				userG.waitreason = waitReasonGarbageCollectionScan
			}

			// TODO: suspendG blocks (and spins) until gp
			// stops, which may take a while for
			// running goroutines. Consider doing this in
			// two phases where the first is non-blocking:
			// we scan the stacks we can and ask running
			// goroutines to scan themselves; and the
			// second blocks.
			stopped := suspendG(gp)
			if stopped.dead {
				gp.gcscandone = true
				return
			}
			if gp.gcscandone {
				throw("g already scanned")
			}
			workDone += scanstack(gp, gcw)
			gp.gcscandone = true
			resumeG(stopped)

			if selfScan {
				casgstatus(userG, _Gwaiting, _Grunning)
			}
		})
	}
	if goexperiment.PacerRedesign {
		if workCounter != nil && workDone != 0 {
			workCounter.Add(workDone)
			if flushBgCredit {
				gcFlushBgCredit(workDone)
			}
		}
	}
	return workDone
}

// markrootBlock scans one element of the list of GC roots.
//
// Returns the amount of work done.
//
//go:nowritebarrier
func markrootBlock(roots *gcRootList, gcw *gcWork) int64 {
	var ret int64
	for i := 0; i < roots.count; i++ {
		r := &roots.roots[i]
		scanblock(uintptr(r.decl), r.ptrdata, r.gcdata, gcw)
		ret += int64(r.ptrdata)
	}
	return ret
}

// markrootSpans marks roots for one shard of markArenas.
//
//go:nowritebarrier
func markrootSpans(gcw *gcWork, shard int) {
	// Objects with finalizers have two GC-related invariants:
	//
	// 1) Everything reachable from the object must be marked.
	// This ensures that when we pass the object to its finalizer,
	// everything the finalizer can reach will be retained.
	//
	// 2) Finalizer specials (which are not in the garbage
	// collected heap) are roots. In practice, this means the fn
	// field must be scanned.
	sg := mheap_.sweepgen

	// Find the arena and page index into that arena for this shard.
	ai := mheap_.markArenas[shard/(pagesPerArena/pagesPerSpanRoot)]
	ha := mheap_.arenas[ai.l1()][ai.l2()]
	arenaPage := uint(uintptr(shard) * pagesPerSpanRoot % pagesPerArena)

	// Construct slice of bitmap which we'll iterate over.
	specialsbits := ha.pageSpecials[arenaPage/8:]
	specialsbits = specialsbits[:pagesPerSpanRoot/8]
	for i := range specialsbits {
		// Find set bits, which correspond to spans with specials.
		specials := atomic.Load8(&specialsbits[i])
		if specials == 0 {
			continue
		}
		for j := uint(0); j < 8; j++ {
			if specials&(1<<j) == 0 {
				continue
			}
			// Find the span for this bit.
			//
			// This value is guaranteed to be non-nil because having
			// specials implies that the span is in-use, and since we're
			// currently marking we can be sure that we don't have to worry
			// about the span being freed and re-used.
			s := ha.spans[arenaPage+uint(i)*8+j]

			// The state must be mSpanInUse if the specials bit is set, so
			// sanity check that.
			if state := s.state.get(); state != mSpanInUse {
				print("s.state = ", state, "\n")
				throw("non in-use span found with specials bit set")
			}
			// Check that this span was swept (it may be cached or uncached).
			if !useCheckmark && !(s.sweepgen == sg || s.sweepgen == sg+3) {
				// sweepgen was updated (+2) during non-checkmark GC pass
				print("sweep ", s.sweepgen, " ", sg, "\n")
				throw("gc: unswept span")
			}

			// Lock the specials to prevent a special from being
			// removed from the list while we're traversing it.
			lock(&s.speciallock)
			for sp := s.specials; sp != nil; sp = sp.next {
				if sp.kind != _KindSpecialFinalizer {
					continue
				}
				// don't mark finalized object, but scan it so we
				// retain everything it points to.
				spf := (*specialfinalizer)(unsafe.Pointer(sp))
				// A finalizer can be set for an inner byte of an object, find object beginning.
				p := s.base() + uintptr(spf.special.offset)/s.elemsize*s.elemsize

				// Mark everything that can be reached from
				// the object (but *not* the object itself or
				// we'll never collect it).
				scanobject(p, gcw)

				// The special itself is a root.
				scanblock(uintptr(unsafe.Pointer(&spf.fn)), goarch.PtrSize, &oneptrmask[0], gcw)
			}
			unlock(&s.speciallock)
		}
	}
}

// gcAssistAlloc performs GC work to make gp's assist debt positive.
// gp must be the calling user goroutine.
//
// This must be called with preemption enabled.
func gcAssistAlloc(gp *g) {
	// Don't assist in non-preemptible contexts. These are
	// generally fragile and won't allow the assist to block.
	if getg() == gp.m.g0 {
		return
	}
	if mp := getg().m; mp.locks > 0 || mp.preemptoff != "" {
		return
	}

	traced := false
retry:
	// Compute the amount of scan work we need to do to make the
	// balance positive. When the required amount of work is low,
	// we over-assist to build up credit for future allocations
	// and amortize the cost of assisting.
	assistWorkPerByte := gcController.assistWorkPerByte.Load()
	assistBytesPerWork := gcController.assistBytesPerWork.Load()
	debtBytes := -gp.gcAssistBytes
	scanWork := int64(assistWorkPerByte * float64(debtBytes))
	if scanWork < gcOverAssistWork {
		scanWork = gcOverAssistWork
		debtBytes = int64(assistBytesPerWork * float64(scanWork))
	}

	// Steal as much credit as we can from the background GC's
	// scan credit. This is racy and may drop the background
	// credit below 0 if two mutators steal at the same time. This
	// will just cause steals to fail until credit is accumulated
	// again, so in the long run it doesn't really matter, but we
	// do have to handle the negative credit case.
	bgScanCredit := atomic.Loadint64(&gcController.bgScanCredit)
	stolen := int64(0)
	if bgScanCredit > 0 {
		if bgScanCredit < scanWork {
			stolen = bgScanCredit
			gp.gcAssistBytes += 1 + int64(assistBytesPerWork*float64(stolen))
		} else {
			stolen = scanWork
			gp.gcAssistBytes += debtBytes
		}
		atomic.Xaddint64(&gcController.bgScanCredit, -stolen)

		scanWork -= stolen

		if scanWork == 0 {
			// We were able to steal all of the credit we
			// needed.
			if traced {
				traceGCMarkAssistDone()
			}
			return
		}
	}

	if trace.enabled && !traced {
		traced = true
		traceGCMarkAssistStart()
	}

	// Perform assist work
	systemstack(func() {
		gcAssistAlloc1(gp, scanWork)
		// The user stack may have moved, so this can't touch
		// anything on it until it returns from systemstack.
	})

	completed := gp.param != nil
	gp.param = nil
	if completed {
		gcMarkDone()
	}

	if gp.gcAssistBytes < 0 {
		// We were unable steal enough credit or perform
		// enough work to pay off the assist debt. We need to
		// do one of these before letting the mutator allocate
		// more to prevent over-allocation.
		//
		// If this is because we were preempted, reschedule
		// and try some more.
		if gp.preempt {
			Gosched()
			goto retry
		}

		// Add this G to an assist queue and park. When the GC
		// has more background credit, it will satisfy queued
		// assists before flushing to the global credit pool.
		//
		// Note that this does *not* get woken up when more
		// work is added to the work list. The theory is that
		// there wasn't enough work to do anyway, so we might
		// as well let background marking take care of the
		// work that is available.
		if !gcParkAssist() {
			goto retry
		}

		// At this point either background GC has satisfied
		// this G's assist debt, or the GC cycle is over.
	}
	if traced {
		traceGCMarkAssistDone()
	}
}

// gcAssistAlloc1 is the part of gcAssistAlloc that runs on the system
// stack. This is a separate function to make it easier to see that
// we're not capturing anything from the user stack, since the user
// stack may move while we're in this function.
//
// gcAssistAlloc1 indicates whether this assist completed the mark
// phase by setting gp.param to non-nil. This can't be communicated on
// the stack since it may move.
//
//go:systemstack
func gcAssistAlloc1(gp *g, scanWork int64) {
	// Clear the flag indicating that this assist completed the
	// mark phase.
	gp.param = nil

	if atomic.Load(&gcBlackenEnabled) == 0 {
		// The gcBlackenEnabled check in malloc races with the
		// store that clears it but an atomic check in every malloc
		// would be a performance hit.
		// Instead we recheck it here on the non-preemptable system
		// stack to determine if we should perform an assist.

		// GC is done, so ignore any remaining debt.
		gp.gcAssistBytes = 0
		return
	}
	// Track time spent in this assist. Since we're on the
	// system stack, this is non-preemptible, so we can
	// just measure start and end time.
	startTime := nanotime()

	decnwait := atomic.Xadd(&work.nwait, -1)
	if decnwait == work.nproc {
		println("runtime: work.nwait =", decnwait, "work.nproc=", work.nproc)
		throw("nwait > work.nprocs")
	}

	// gcDrainN requires the caller to be preemptible.
	casgstatus(gp, _Grunning, _Gwaiting)
	gp.waitreason = waitReasonGCAssistMarking

	// drain own cached work first in the hopes that it
	// will be more cache friendly.
	gcw := &getg().m.p.ptr().gcw
	workDone := gcDrainN(gcw, scanWork)

	casgstatus(gp, _Gwaiting, _Grunning)

	// Record that we did this much scan work.
	//
	// Back out the number of bytes of assist credit that
	// this scan work counts for. The "1+" is a poor man's
	// round-up, to ensure this adds credit even if
	// assistBytesPerWork is very low.
	assistBytesPerWork := gcController.assistBytesPerWork.Load()
	gp.gcAssistBytes += 1 + int64(assistBytesPerWork*float64(workDone))

	// If this is the last worker and we ran out of work,
	// signal a completion point.
	incnwait := atomic.Xadd(&work.nwait, +1)
	if incnwait > work.nproc {
		println("runtime: work.nwait=", incnwait,
			"work.nproc=", work.nproc)
		throw("work.nwait > work.nproc")
	}

	if incnwait == work.nproc && !gcMarkWorkAvailable(nil) {
		// This has reached a background completion point. Set
		// gp.param to a non-nil value to indicate this. It
		// doesn't matter what we set it to (it just has to be
		// a valid pointer).
		gp.param = unsafe.Pointer(gp)
	}
	duration := nanotime() - startTime
	_p_ := gp.m.p.ptr()
	_p_.gcAssistTime += duration
	if _p_.gcAssistTime > gcAssistTimeSlack {
		atomic.Xaddint64(&gcController.assistTime, _p_.gcAssistTime)
		_p_.gcAssistTime = 0
	}
}

// gcWakeAllAssists wakes all currently blocked assists. This is used
// at the end of a GC cycle. gcBlackenEnabled must be false to prevent
// new assists from going to sleep after this point.
func gcWakeAllAssists() {
	lock(&work.assistQueue.lock)
	list := work.assistQueue.q.popList()
	injectglist(&list)
	unlock(&work.assistQueue.lock)
}

// gcParkAssist puts the current goroutine on the assist queue and parks.
//
// gcParkAssist reports whether the assist is now satisfied. If it
// returns false, the caller must retry the assist.
func gcParkAssist() bool {
	lock(&work.assistQueue.lock)
	// If the GC cycle finished while we were getting the lock,
	// exit the assist. The cycle can't finish while we hold the
	// lock.
	if atomic.Load(&gcBlackenEnabled) == 0 {
		unlock(&work.assistQueue.lock)
		return true
	}

	gp := getg()
	oldList := work.assistQueue.q
	work.assistQueue.q.pushBack(gp)

	// Recheck for background credit now that this G is in
	// the queue, but can still back out. This avoids a
	// race in case background marking has flushed more
	// credit since we checked above.
	if atomic.Loadint64(&gcController.bgScanCredit) > 0 {
		work.assistQueue.q = oldList
		if oldList.tail != 0 {
			oldList.tail.ptr().schedlink.set(nil)
		}
		unlock(&work.assistQueue.lock)
		return false
	}
	// Park.
	goparkunlock(&work.assistQueue.lock, waitReasonGCAssistWait, traceEvGoBlockGC, 2)
	return true
}

// gcFlushBgCredit flushes scanWork units of background scan work
// credit. This first satisfies blocked assists on the
// work.assistQueue and then flushes any remaining credit to
// gcController.bgScanCredit.
//
// Write barriers are disallowed because this is used by gcDrain after
// it has ensured that all work is drained and this must preserve that
// condition.
//
//go:nowritebarrierrec
func gcFlushBgCredit(scanWork int64) {
	if work.assistQueue.q.empty() {
		// Fast path; there are no blocked assists. There's a
		// small window here where an assist may add itself to
		// the blocked queue and park. If that happens, we'll
		// just get it on the next flush.
		atomic.Xaddint64(&gcController.bgScanCredit, scanWork)
		return
	}

	assistBytesPerWork := gcController.assistBytesPerWork.Load()
	scanBytes := int64(float64(scanWork) * assistBytesPerWork)

	lock(&work.assistQueue.lock)
	for !work.assistQueue.q.empty() && scanBytes > 0 {
		gp := work.assistQueue.q.pop()
		// Note that gp.gcAssistBytes is negative because gp
		// is in debt. Think carefully about the signs below.
		if scanBytes+gp.gcAssistBytes >= 0 {
			// Satisfy this entire assist debt.
			scanBytes += gp.gcAssistBytes
			gp.gcAssistBytes = 0
			// It's important that we *not* put gp in
			// runnext. Otherwise, it's possible for user
			// code to exploit the GC worker's high
			// scheduler priority to get itself always run
			// before other goroutines and always in the
			// fresh quantum started by GC.
			ready(gp, 0, false)
		} else {
			// Partially satisfy this assist.
			gp.gcAssistBytes += scanBytes
			scanBytes = 0
			// As a heuristic, we move this assist to the
			// back of the queue so that large assists
			// can't clog up the assist queue and
			// substantially delay small assists.
			work.assistQueue.q.pushBack(gp)
			break
		}
	}

	if scanBytes > 0 {
		// Convert from scan bytes back to work.
		assistWorkPerByte := gcController.assistWorkPerByte.Load()
		scanWork = int64(float64(scanBytes) * assistWorkPerByte)
		atomic.Xaddint64(&gcController.bgScanCredit, scanWork)
	}
	unlock(&work.assistQueue.lock)
}

// We use a C function to find the stack.
// Returns whether we succesfully scanned the stack.
func doscanstack(*g, *gcWork) bool

func doscanstackswitch(*g, *g)

// scanstack scans gp's stack, greying all pointers found on the stack.
//
// For goexperiment.PacerRedesign:
// Returns the amount of scan work performed, but doesn't update
// gcController.stackScanWork or flush any credit. Any background credit produced
// by this function should be flushed by its caller. scanstack itself can't
// safely flush because it may result in trying to wake up a goroutine that
// was just scanned, resulting in a self-deadlock.
//
// scanstack will also shrink the stack if it is safe to do so. If it
// is not, it schedules a stack shrink for the next synchronous safe
// point.
//
// scanstack is marked go:systemstack because it must not be preempted
// while using a workbuf.
//
//go:nowritebarrier
//go:systemstack
func scanstack(gp *g, gcw *gcWork) int64 {
	if readgstatus(gp)&_Gscan == 0 {
		print("runtime:scanstack: gp=", gp, ", goid=", gp.goid, ", gp->atomicstatus=", hex(readgstatus(gp)), "\n")
		throw("scanstack - bad status")
	}

	switch readgstatus(gp) &^ _Gscan {
	default:
		print("runtime: gp=", gp, ", goid=", gp.goid, ", gp->atomicstatus=", readgstatus(gp), "\n")
		throw("mark - bad status")
	case _Gdead:
		return 0
	case _Grunning:
		print("runtime: gp=", gp, ", goid=", gp.goid, ", gp->atomicstatus=", readgstatus(gp), "\n")
		throw("scanstack: goroutine not stopped")
	case _Grunnable, _Gsyscall, _Gwaiting:
		// ok
	}

	// Scan the stack.
	if usestackmaps {
		g := getg()
		if g == gp {
			// Scan its own stack.
			doscanstack(gp, gcw)
		} else if gp.entry != nil {
			// This is a newly created g that hasn't run. No stack to scan.
		} else if readgstatus(gp)&^_Gscan == _Gsyscall {
			scanSyscallStack(gp, gcw)
		} else {
			// Scanning another g's stack. We need to switch to that g
			// to unwind its stack. And switch back after scan.
			scanstackswitch(gp, gcw)
		}
	} else {
		doscanstack(gp, gcw)

		// Conservatively scan the saved register values.
		scanstackblock(uintptr(unsafe.Pointer(&gp.gcregs)), unsafe.Sizeof(gp.gcregs), gcw)
		scanstackblock(uintptr(unsafe.Pointer(&gp.context)), unsafe.Sizeof(gp.context), gcw)
	}

	// Note: in the gc runtime scanstack also scans defer records.
	// This is necessary as it uses stack objects (a.k.a. stack tracing).
	// We don't (yet) do stack objects, and regular stack/heap scan
	// will take care of defer records just fine.

	return 0
}

// scanstackswitch scans gp's stack by switching (gogo) to gp and
// letting it scan its own stack, and switching back upon finish.
//
//go:nowritebarrier
func scanstackswitch(gp *g, gcw *gcWork) {
	g := getg()

	// We are on the system stack which prevents preemption. But
	// we are going to switch to g stack. Lock m to block preemption.
	mp := acquirem()

	// The doscanstackswitch function will modify the current g's
	// context. Preserve it.
	// The stack scan code may call systemstack, which will modify
	// gp's context. Preserve it as well so we can resume gp.
	context := g.context
	stackcontext := g.stackcontext
	context2 := gp.context
	stackcontext2 := gp.stackcontext

	gp.scangcw = uintptr(unsafe.Pointer(gcw))
	gp.scang = uintptr(unsafe.Pointer(g))
	doscanstackswitch(g, gp)

	// Restore the contexts.
	g.context = context
	g.stackcontext = stackcontext
	gp.context = context2
	gp.stackcontext = stackcontext2
	gp.scangcw = 0
	// gp.scang is already cleared in C code.

	releasem(mp)
}

// scanSyscallStack scans the stack of a goroutine blocked in a
// syscall by waking it up and asking it to scan its own stack.
func scanSyscallStack(gp *g, gcw *gcWork) {
	if gp.scanningself {
		// We've suspended the goroutine by setting the _Gscan bit,
		// so this shouldn't be possible.
		throw("scanSyscallStack: scanningself")
	}
	if gp.gcscandone {
		// We've suspended the goroutine by setting the _Gscan bit,
		// so this shouldn't be possible.

		throw("scanSyscallStack: gcscandone")
	}

	gp.gcScannedSyscallStack = false
	for {
		mp := gp.m
		noteclear(&mp.scannote)
		gp.scangcw = uintptr(unsafe.Pointer(gcw))
		tgkill(getpid(), _pid_t(mp.procid), _SIGURG)
		// Wait for gp to scan its own stack.
		notesleep(&mp.scannote)
		if gp.gcScannedSyscallStack {
			return
		}

		// The signal was delivered at a bad time.  Try again.
		osyield()
	}
}

type gcDrainFlags int

const (
	gcDrainUntilPreempt gcDrainFlags = 1 << iota
	gcDrainFlushBgCredit
	gcDrainIdle
	gcDrainFractional
)

// gcDrain scans roots and objects in work buffers, blackening grey
// objects until it is unable to get more work. It may return before
// GC is done; it's the caller's responsibility to balance work from
// other Ps.
//
// If flags&gcDrainUntilPreempt != 0, gcDrain returns when g.preempt
// is set.
//
// If flags&gcDrainIdle != 0, gcDrain returns when there is other work
// to do.
//
// If flags&gcDrainFractional != 0, gcDrain self-preempts when
// pollFractionalWorkerExit() returns true. This implies
// gcDrainNoBlock.
//
// If flags&gcDrainFlushBgCredit != 0, gcDrain flushes scan work
// credit to gcController.bgScanCredit every gcCreditSlack units of
// scan work.
//
// gcDrain will always return if there is a pending STW.
//
//go:nowritebarrier
func gcDrain(gcw *gcWork, flags gcDrainFlags) {
	if !writeBarrier.needed {
		throw("gcDrain phase incorrect")
	}

	gp := getg().m.curg
	preemptible := flags&gcDrainUntilPreempt != 0
	flushBgCredit := flags&gcDrainFlushBgCredit != 0
	idle := flags&gcDrainIdle != 0

	initScanWork := gcw.heapScanWork

	// checkWork is the scan work before performing the next
	// self-preempt check.
	checkWork := int64(1<<63 - 1)
	var check func() bool
	if flags&(gcDrainIdle|gcDrainFractional) != 0 {
		checkWork = initScanWork + drainCheckThreshold
		if idle {
			check = pollWork
		} else if flags&gcDrainFractional != 0 {
			check = pollFractionalWorkerExit
		}
	}

	// Drain root marking jobs.
	if work.markrootNext < work.markrootJobs {
		// Stop if we're preemptible or if someone wants to STW.
		for !(gp.preempt && (preemptible || atomic.Load(&sched.gcwaiting) != 0)) {
			job := atomic.Xadd(&work.markrootNext, +1) - 1
			if job >= work.markrootJobs {
				break
			}
			markroot(gcw, job, flushBgCredit)
			if check != nil && check() {
				goto done
			}
		}
	}

	// Drain heap marking jobs.
	// Stop if we're preemptible or if someone wants to STW.
	for !(gp.preempt && (preemptible || atomic.Load(&sched.gcwaiting) != 0)) {
		// Try to keep work available on the global queue. We used to
		// check if there were waiting workers, but it's better to
		// just keep work available than to make workers wait. In the
		// worst case, we'll do O(log(_WorkbufSize)) unnecessary
		// balances.
		if work.full == 0 {
			gcw.balance()
		}

		b := gcw.tryGetFast()
		if b == 0 {
			b = gcw.tryGet()
			if b == 0 {
				// Flush the write barrier
				// buffer; this may create
				// more work.
				wbBufFlush(nil, 0)
				b = gcw.tryGet()
			}
		}
		if b == 0 {
			// Unable to get work.
			break
		}
		scanobject(b, gcw)

		// Flush background scan work credit to the global
		// account if we've accumulated enough locally so
		// mutator assists can draw on it.
		if gcw.heapScanWork >= gcCreditSlack {
			gcController.heapScanWork.Add(gcw.heapScanWork)
			if flushBgCredit {
				gcFlushBgCredit(gcw.heapScanWork - initScanWork)
				initScanWork = 0
			}
			checkWork -= gcw.heapScanWork
			gcw.heapScanWork = 0

			if checkWork <= 0 {
				checkWork += drainCheckThreshold
				if check != nil && check() {
					break
				}
			}
		}
	}

done:
	// Flush remaining scan work credit.
	if gcw.heapScanWork > 0 {
		gcController.heapScanWork.Add(gcw.heapScanWork)
		if flushBgCredit {
			gcFlushBgCredit(gcw.heapScanWork - initScanWork)
		}
		gcw.heapScanWork = 0
	}
}

// gcDrainN blackens grey objects until it has performed roughly
// scanWork units of scan work or the G is preempted. This is
// best-effort, so it may perform less work if it fails to get a work
// buffer. Otherwise, it will perform at least n units of work, but
// may perform more because scanning is always done in whole object
// increments. It returns the amount of scan work performed.
//
// The caller goroutine must be in a preemptible state (e.g.,
// _Gwaiting) to prevent deadlocks during stack scanning. As a
// consequence, this must be called on the system stack.
//
//go:nowritebarrier
//go:systemstack
func gcDrainN(gcw *gcWork, scanWork int64) int64 {
	if !writeBarrier.needed {
		throw("gcDrainN phase incorrect")
	}

	// There may already be scan work on the gcw, which we don't
	// want to claim was done by this call.
	workFlushed := -gcw.heapScanWork

	gp := getg().m.curg
	for !gp.preempt && workFlushed+gcw.heapScanWork < scanWork {
		// See gcDrain comment.
		if work.full == 0 {
			gcw.balance()
		}

		b := gcw.tryGetFast()
		if b == 0 {
			b = gcw.tryGet()
			if b == 0 {
				// Flush the write barrier buffer;
				// this may create more work.
				wbBufFlush(nil, 0)
				b = gcw.tryGet()
			}
		}

		if b == 0 {
			// Try to do a root job.
			if work.markrootNext < work.markrootJobs {
				job := atomic.Xadd(&work.markrootNext, +1) - 1
				if job < work.markrootJobs {
					work := markroot(gcw, job, false)
					if goexperiment.PacerRedesign {
						workFlushed += work
					}
					continue
				}
			}
			// No heap or root jobs.
			break
		}

		scanobject(b, gcw)

		// Flush background scan work credit.
		if gcw.heapScanWork >= gcCreditSlack {
			gcController.heapScanWork.Add(gcw.heapScanWork)
			workFlushed += gcw.heapScanWork
			gcw.heapScanWork = 0
		}
	}

	// Unlike gcDrain, there's no need to flush remaining work
	// here because this never flushes to bgScanCredit and
	// gcw.dispose will flush any remaining work to scanWork.

	return workFlushed + gcw.heapScanWork
}

// scanblock scans b as scanobject would, but using an explicit
// pointer bitmap instead of the heap bitmap.
//
// This is used to scan non-heap roots, so it does not update
// gcw.bytesMarked or gcw.heapScanWork.
//
//go:nowritebarrier
func scanblock(b0, n0 uintptr, ptrmask *uint8, gcw *gcWork) {
	// Use local copies of original parameters, so that a stack trace
	// due to one of the throws below shows the original block
	// base and extent.
	b := b0
	n := n0

	for i := uintptr(0); i < n; {
		// Find bits for the next word.
		bits := uint32(*addb(ptrmask, i/(goarch.PtrSize*8)))
		if bits == 0 {
			i += goarch.PtrSize * 8
			continue
		}
		for j := 0; j < 8 && i < n; j++ {
			if bits&1 != 0 {
				// Same work as in scanobject; see comments there.
				p := *(*uintptr)(unsafe.Pointer(b + i))
				if p != 0 {
					if obj, span, objIndex := findObject(p, b, i, false); obj != 0 {
						greyobject(obj, b, i, span, gcw, objIndex, false)
					}
				}
			}
			bits >>= 1
			i += goarch.PtrSize
		}
	}
}

// scanobject scans the object starting at b, adding pointers to gcw.
// b must point to the beginning of a heap object or an oblet.
// scanobject consults the GC bitmap for the pointer mask and the
// spans for the size of the object.
//
//go:nowritebarrier
func scanobject(b uintptr, gcw *gcWork) {
	// Prefetch object before we scan it.
	//
	// This will overlap fetching the beginning of the object with initial
	// setup before we start scanning the object.
	sys.Prefetch(b)

	// Find the bits for b and the size of the object at b.
	//
	// b is either the beginning of an object, in which case this
	// is the size of the object to scan, or it points to an
	// oblet, in which case we compute the size to scan below.
	hbits := heapBitsForAddr(b)
	s := spanOfUnchecked(b)
	n := s.elemsize
	if n == 0 {
		throw("scanobject n == 0")
	}

	if n > maxObletBytes {
		// Large object. Break into oblets for better
		// parallelism and lower latency.
		if b == s.base() {
			// It's possible this is a noscan object (not
			// from greyobject, but from other code
			// paths), in which case we must *not* enqueue
			// oblets since their bitmaps will be
			// uninitialized.
			if s.spanclass.noscan() {
				// Bypass the whole scan.
				gcw.bytesMarked += uint64(n)
				return
			}

			// Enqueue the other oblets to scan later.
			// Some oblets may be in b's scalar tail, but
			// these will be marked as "no more pointers",
			// so we'll drop out immediately when we go to
			// scan those.
			for oblet := b + maxObletBytes; oblet < s.base()+s.elemsize; oblet += maxObletBytes {
				if !gcw.putFast(oblet) {
					gcw.put(oblet)
				}
			}
		}

		// Compute the size of the oblet. Since this object
		// must be a large object, s.base() is the beginning
		// of the object.
		n = s.base() + s.elemsize - b
		if n > maxObletBytes {
			n = maxObletBytes
		}
	}

	var i uintptr
	for i = 0; i < n; i, hbits = i+goarch.PtrSize, hbits.next() {
		// Load bits once. See CL 22712 and issue 16973 for discussion.
		bits := hbits.bits()
		if bits&bitScan == 0 {
			break // no more pointers in this object
		}
		if bits&bitPointer == 0 {
			continue // not a pointer
		}

		// Work here is duplicated in scanblock and above.
		// If you make changes here, make changes there too.
		obj := *(*uintptr)(unsafe.Pointer(b + i))

		// At this point we have extracted the next potential pointer.
		// Quickly filter out nil and pointers back to the current object.
		if obj != 0 && obj-b >= n {
			// Test if obj points into the Go heap and, if so,
			// mark the object.
			//
			// Note that it's possible for findObject to
			// fail if obj points to a just-allocated heap
			// object because of a race with growing the
			// heap. In this case, we know the object was
			// just allocated and hence will be marked by
			// allocation itself.
			if obj, span, objIndex := findObject(obj, b, i, false); obj != 0 {
				greyobject(obj, b, i, span, gcw, objIndex, false)
			}
		}
	}
	gcw.bytesMarked += uint64(n)
	gcw.heapScanWork += int64(i)
}

//go:linkname scanstackblock

// scanstackblock is called by the stack scanning code in C to
// actually find and mark pointers in the stack block. This is like
// scanblock, but we scan the stack conservatively, so there is no
// bitmask of pointers.
func scanstackblock(b, n uintptr, gcw *gcWork) {
	if usestackmaps {
		throw("scanstackblock: conservative scan but stack map is used")
	}

	for i := uintptr(0); i < n; i += goarch.PtrSize {
		// Same work as in scanobject; see comments there.
		obj := *(*uintptr)(unsafe.Pointer(b + i))
		if obj, span, objIndex := findObject(obj, b, i, true); obj != 0 {
			greyobject(obj, b, i, span, gcw, objIndex, true)
		}
	}
}

// scanstackblockwithmap is like scanstackblock, but with an explicit
// pointer bitmap. This is used only when precise stack scan is enabled.
//go:linkname scanstackblockwithmap
//go:nowritebarrier
func scanstackblockwithmap(pc, b0, n0 uintptr, ptrmask *uint8, gcw *gcWork) {
	// Use local copies of original parameters, so that a stack trace
	// due to one of the throws below shows the original block
	// base and extent.
	b := b0
	n := n0

	for i := uintptr(0); i < n; {
		// Find bits for the next word.
		bits := uint32(*addb(ptrmask, i/(goarch.PtrSize*8)))
		if bits == 0 {
			i += goarch.PtrSize * 8
			continue
		}
		for j := 0; j < 8 && i < n; j++ {
			if bits&1 != 0 {
				// Same work as in scanobject; see comments there.
				obj := *(*uintptr)(unsafe.Pointer(b + i))
				if obj != 0 {
					o, span, objIndex := findObject(obj, b, i, false)
					if obj < minPhysPageSize ||
						span != nil && span.state.get() != mSpanManual &&
							(obj < span.base() || obj >= span.limit || span.state.get() != mSpanInUse) {
						print("runtime: found in object at *(", hex(b), "+", hex(i), ") = ", hex(obj), ", pc=", hex(pc), "\n")
						name, file, line, _ := funcfileline(pc, -1, false)
						print(name, "\n", file, ":", line, "\n")
						//gcDumpObject("object", b, i)
						throw("found bad pointer in Go stack (incorrect use of unsafe or cgo?)")
					}
					if o != 0 {
						greyobject(o, b, i, span, gcw, objIndex, false)
					}
				}
			}
			bits >>= 1
			i += goarch.PtrSize
		}
	}
}

// Shade the object if it isn't already.
// The object is not nil and known to be in the heap.
// Preemption must be disabled.
//go:nowritebarrier
func shade(b uintptr) {
	if obj, span, objIndex := findObject(b, 0, 0, !usestackmaps); obj != 0 {
		gcw := &getg().m.p.ptr().gcw
		greyobject(obj, 0, 0, span, gcw, objIndex, !usestackmaps)
	}
}

// obj is the start of an object with mark mbits.
// If it isn't already marked, mark it and enqueue into gcw.
// base and off are for debugging only and could be removed.
//
// See also wbBufFlush1, which partially duplicates this logic.
//
//go:nowritebarrierrec
func greyobject(obj, base, off uintptr, span *mspan, gcw *gcWork, objIndex uintptr, forStack bool) {
	// obj should be start of allocation, and so must be at least pointer-aligned.
	if obj&(goarch.PtrSize-1) != 0 {
		throw("greyobject: obj not pointer-aligned")
	}
	mbits := span.markBitsForIndex(objIndex)

	if useCheckmark {
		if setCheckmark(obj, base, off, mbits, forStack) {
			// Already marked.
			return
		}
	} else {
		// Stack scanning is conservative, so we can see a
		// pointer to a free object. Assume the object was
		// correctly freed and we must ignore the pointer.
		if forStack && span.isFree(objIndex) {
			return
		}

		if debug.gccheckmark > 0 && span.isFree(objIndex) {
			print("runtime: marking free object ", hex(obj), " found at *(", hex(base), "+", hex(off), ")\n")
			gcDumpObject("base", base, off)
			gcDumpObject("obj", obj, ^uintptr(0))
			getg().m.traceback = 2
			throw("marking free object")
		}

		// If marked we have nothing to do.
		if mbits.isMarked() {
			return
		}
		mbits.setMarked()

		// Mark span.
		arena, pageIdx, pageMask := pageIndexOf(span.base())
		if arena.pageMarks[pageIdx]&pageMask == 0 {
			atomic.Or8(&arena.pageMarks[pageIdx], pageMask)
		}

		// If this is a noscan object, fast-track it to black
		// instead of greying it.
		if span.spanclass.noscan() {
			gcw.bytesMarked += uint64(span.elemsize)
			return
		}
	}

	// We're adding obj to P's local workbuf, so it's likely
	// this object will be processed soon by the same P.
	// Even if the workbuf gets flushed, there will likely still be
	// some benefit on platforms with inclusive shared caches.
	sys.Prefetch(obj)
	// Queue the obj for scanning.
	if !gcw.putFast(obj) {
		gcw.put(obj)
	}
}

// gcDumpObject dumps the contents of obj for debugging and marks the
// field at byte offset off in obj.
func gcDumpObject(label string, obj, off uintptr) {
	s := spanOf(obj)
	print(label, "=", hex(obj))
	if s == nil {
		print(" s=nil\n")
		return
	}
	print(" s.base()=", hex(s.base()), " s.limit=", hex(s.limit), " s.spanclass=", s.spanclass, " s.elemsize=", s.elemsize, " s.state=")
	if state := s.state.get(); 0 <= state && int(state) < len(mSpanStateNames) {
		print(mSpanStateNames[state], "\n")
	} else {
		print("unknown(", state, ")\n")
	}

	skipped := false
	size := s.elemsize
	if s.state.get() == mSpanManual && size == 0 {
		// We're printing something from a stack frame. We
		// don't know how big it is, so just show up to an
		// including off.
		size = off + goarch.PtrSize
	}
	for i := uintptr(0); i < size; i += goarch.PtrSize {
		// For big objects, just print the beginning (because
		// that usually hints at the object's type) and the
		// fields around off.
		if !(i < 128*goarch.PtrSize || off-16*goarch.PtrSize < i && i < off+16*goarch.PtrSize) {
			skipped = true
			continue
		}
		if skipped {
			print(" ...\n")
			skipped = false
		}
		print(" *(", label, "+", i, ") = ", hex(*(*uintptr)(unsafe.Pointer(obj + i))))
		if i == off {
			print(" <==")
		}
		print("\n")
	}
	if skipped {
		print(" ...\n")
	}
}

// gcmarknewobject marks a newly allocated object black. obj must
// not contain any non-nil pointers.
//
// This is nosplit so it can manipulate a gcWork without preemption.
//
//go:nowritebarrier
//go:nosplit
func gcmarknewobject(span *mspan, obj, size, scanSize uintptr) {
	if useCheckmark { // The world should be stopped so this should not happen.
		throw("gcmarknewobject called while doing checkmark")
	}

	// Mark object.
	objIndex := span.objIndex(obj)
	span.markBitsForIndex(objIndex).setMarked()

	// Mark span.
	arena, pageIdx, pageMask := pageIndexOf(span.base())
	if arena.pageMarks[pageIdx]&pageMask == 0 {
		atomic.Or8(&arena.pageMarks[pageIdx], pageMask)
	}

	gcw := &getg().m.p.ptr().gcw
	gcw.bytesMarked += uint64(size)
	if !goexperiment.PacerRedesign {
		// The old pacer counts newly allocated memory toward
		// heapScanWork because heapScan is continuously updated
		// throughout the GC cycle with newly allocated memory. However,
		// these objects are never actually scanned, so we need
		// to account for them in heapScanWork here, "faking" their work.
		// Otherwise the pacer will think it's always behind, potentially
		// by a large margin.
		//
		// The new pacer doesn't care about this because it ceases to updated
		// heapScan once a GC cycle starts, effectively snapshotting it.
		gcw.heapScanWork += int64(scanSize)
	}
}

// gcMarkTinyAllocs greys all active tiny alloc blocks.
//
// The world must be stopped.
func gcMarkTinyAllocs() {
	assertWorldStopped()

	for _, p := range allp {
		c := p.mcache
		if c == nil || c.tiny == 0 {
			continue
		}
		_, span, objIndex := findObject(c.tiny, 0, 0, false)
		gcw := &p.gcw
		greyobject(c.tiny, 0, 0, span, gcw, objIndex, false)
	}
}
