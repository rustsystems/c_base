; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -passes=gvn-sink -S %s | FileCheck %s

declare i32 @foo()

define void @loop1() {
; CHECK-LABEL: define void @loop1() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[C1:%.*]] = call i32 @foo()
; CHECK-NEXT:    br label [[LOOP]]
;
entry:
  %c1 = call i32 @foo()
  br label %loop

loop:
  %c2 = call i32 @foo()
  br label %loop
}

define void @uncond_succ_no_loop() {
; CHECK-LABEL: define void @uncond_succ_no_loop() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C1:%.*]] = call i32 @foo()
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[C2:%.*]] = call i32 @foo()
; CHECK-NEXT:    ret void
;
entry:
  %c1 = call i32 @foo()
  br label %exit

exit:
  %c2 = call i32 @foo()
  ret void
}

define void @loop_with_store(ptr %a) {
; CHECK-LABEL: define void @loop_with_store
; CHECK-SAME: (ptr [[A:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C1:%.*]] = call i32 @foo()
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[C2:%.*]] = call i32 @foo()
; CHECK-NEXT:    store i32 0, ptr [[A]], align 4
; CHECK-NEXT:    br label [[LOOP]]
;
entry:
  %c1 = call i32 @foo()
  br label %loop

loop:
  %c2 = call i32 @foo()
  store i32 0, ptr %a
  br label %loop
}

define void @loop_linked_latches() {
; CHECK-LABEL: define void @loop_linked_latches() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C1:%.*]] = call i32 @foo()
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[C2:%.*]] = call i32 @foo()
; CHECK-NEXT:    [[C:%.*]] = icmp eq i32 [[C2]], 100
; CHECK-NEXT:    br i1 [[C]], label [[LATCH_1:%.*]], label [[EXIT:%.*]]
; CHECK:       latch.1:
; CHECK-NEXT:    br label [[LATCH_2:%.*]]
; CHECK:       latch.2:
; CHECK-NEXT:    br label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %c1 = call i32 @foo()
  br label %loop

loop:
  %c2  = call i32 @foo()
  %c = icmp eq i32 %c2, 100
  br i1 %c, label %latch.1, label %exit

latch.1:
  br label %latch.2

latch.2:
  br label %loop


exit:
  ret void
}

define void @loop_with_branch(i32 %s) {
; CHECK-LABEL: define void @loop_with_branch
; CHECK-SAME: (i32 [[S:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[C1:%.*]] = call i32 @foo()
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[S]], 100
; CHECK-NEXT:    br i1 [[CMP]], label [[LOOP_LATCH:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %c1 = call i32 @foo()
  br label %loop.header

loop.header:
  %cmp = icmp eq i32 %s, 100
  br i1 %cmp, label %loop.latch, label %exit

loop.latch:
  %c2 = call i32 @foo()
  br label %loop.header

exit:
  ret void
}

define void @loop_with_switch(i32 %s) {
; CHECK-LABEL: define void @loop_with_switch
; CHECK-SAME: (i32 [[S:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[C1:%.*]] = call i32 @foo()
; CHECK-NEXT:    switch i32 [[S]], label [[LOOP_LATCH:%.*]] [
; CHECK-NEXT:    i32 0, label [[EXIT:%.*]]
; CHECK-NEXT:    ]
; CHECK:       loop.latch:
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %c1 = call i32 @foo()
  br label %loop.header

loop.header:
  switch i32 %s, label %loop.latch [
  i32 0, label %exit
  ]

loop.latch:
  %c2 = call i32 @foo()
  br label %loop.header

exit:
  ret void
}

define void @cycle_latch_not_dominated_by_header_branch(i1 %c, i32 %s) {
; CHECK-LABEL: define void @cycle_latch_not_dominated_by_header_branch
; CHECK-SAME: (i1 [[C:%.*]], i32 [[S:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C]], label [[THEN:%.*]], label [[CYCLE_2:%.*]]
; CHECK:       then:
; CHECK-NEXT:    br label [[CYCLE_1:%.*]]
; CHECK:       cycle.1:
; CHECK-NEXT:    [[C1:%.*]] = call i32 @foo()
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[S]], 100
; CHECK-NEXT:    br i1 [[CMP]], label [[EXIT:%.*]], label [[CYCLE_2]]
; CHECK:       cycle.2:
; CHECK-NEXT:    br label [[CYCLE_1]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %then, label %cycle.2

then:
  %c1 = call i32 @foo()
  br label %cycle.1

cycle.1:
  %cmp = icmp eq i32 %s, 100
  br i1 %cmp, label %exit, label %cycle.2

cycle.2:
  %c2 = call i32 @foo()
  br label %cycle.1

exit:
  ret void
}

define void @cycle_latch_not_dominated_by_header_switch(i1 %c, i32 %s) {
; CHECK-LABEL: define void @cycle_latch_not_dominated_by_header_switch
; CHECK-SAME: (i1 [[C:%.*]], i32 [[S:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C]], label [[THEN:%.*]], label [[CYCLE_2:%.*]]
; CHECK:       then:
; CHECK-NEXT:    br label [[CYCLE_1:%.*]]
; CHECK:       cycle.1:
; CHECK-NEXT:    [[C1:%.*]] = call i32 @foo()
; CHECK-NEXT:    switch i32 [[S]], label [[EXIT:%.*]] [
; CHECK-NEXT:    i32 0, label [[CYCLE_2]]
; CHECK-NEXT:    ]
; CHECK:       cycle.2:
; CHECK-NEXT:    br label [[CYCLE_1]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %then, label %cycle.2

then:
  %c1 = call i32 @foo()
  br label %cycle.1

cycle.1:
  switch i32 %s, label %exit [
  i32 0, label %cycle.2
  ]

cycle.2:
  %c2 = call i32 @foo()
  br label %cycle.1

exit:
  ret void
}

