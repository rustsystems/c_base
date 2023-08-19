Concurrency support library
 C Concurrency support library 
C includes built-in support for threads, atomic operations, mutual exclusion, condition variables, and thread-specific storages.

These features are optionally provided:

if the macro constant __STDC_NO_THREADS__ is defined by the compiler, the header <threads.h> and all of the names provided in it are not provided;
if the macro constant __STDC_NO_ATOMICS__ is defined by the compiler, the header <stdatomic.h> and all of the names provided in it are not provided.
See also _Atomic type specifier and qualifier.

Threads
Defined in header <threads.h>
thrd_t	implementation-defined complete object type identifying a thread
thrd_create
  
(C11)
 
creates a thread
(function)
thrd_equal
  
(C11)
 
checks if two identifiers refer to the same thread
(function)
thrd_current
  
(C11)
 
obtains the current thread identifier
(function)
thrd_sleep
  
(C11)
 
suspends execution of the calling thread for the given period of time
(function)
thrd_yield
  
(C11)
 
yields the current time slice
(function)
thrd_exit
  
(C11)
 
terminates the calling thread
(function)
thrd_detach
  
(C11)
 
detaches a thread
(function)
thrd_join
  
(C11)
 
blocks until a thread terminates
(function)
thrd_success
thrd_timedout
thrd_busy
thrd_nomem
thrd_error
  
(C11)
 
indicates a thread error status
(constant)
thrd_start_t
  
(C11)
 
a typedef of the function pointer type int(*)(void*), used by thrd_create
(typedef)








Mutual exclusion
Defined in header <threads.h>
mtx_t	mutex identifier
mtx_init
  
(C11)
 
creates a mutex
(function)
mtx_lock
  
(C11)
 
blocks until locks a mutex
(function)
mtx_timedlock
  
(C11)
 
blocks until locks a mutex or times out
(function)
mtx_trylock
  
(C11)
 
locks a mutex or returns without blocking if already locked
(function)
mtx_unlock
  
(C11)
 
unlocks a mutex
(function)
mtx_destroy
  
(C11)
 
destroys a mutex
(function)
mtx_plain
mtx_recursive
mtx_timed
  
(C11)
(C11)
(C11)
 
defines the type of a mutex
(enum)
Call once
call_once
  
(C11)
 
calls a function exactly once
(function)
Condition variables
Defined in header <threads.h>
cnd_t	condition variable identifier
cnd_init
  
(C11)
 
creates a condition variable
(function)
cnd_signal
  
(C11)
 
unblocks one thread blocked on a condition variable
(function)
cnd_broadcast
  
(C11)
 
unblocks all threads blocked on a condition variable
(function)
cnd_wait
  
(C11)
 
blocks on a condition variable
(function)
cnd_timedwait
  
(C11)
 
blocks on a condition variable, with a timeout
(function)
cnd_destroy
  
(C11)
 
destroys a condition variable
(function)
Thread-local storage
Defined in header <threads.h>
thread_local
  
(C11)(removed in C23)
 
convenience macro for storage-class specifier _Thread_local
(keyword macro)
tss_t	thread-specific storage pointer
TSS_DTOR_ITERATIONS
  
(C11)
 
maximum number of times destructors are called
(macro constant)
tss_dtor_t	function pointer type void(*)(void*), used for TSS destructor
tss_create
  
(C11)
 
creates thread-specific storage pointer with a given destructor
(function)
tss_get
  
(C11)
 
reads from thread-specific storage
(function)
tss_set
  
(C11)
 
write to thread-specific storage
(function)
tss_delete
  
(C11)
 
releases the resources held by a given thread-specific pointer
(function)
Reserved identifiers
In future revisions of the C standard:

function names, type names, and enumeration constants that begin with either cnd_, mtx_, thrd_, or tss_, and a lowercase letter may be added to the declarations in the <threads.h> header;
macros that begin with ATOMIC_ and an uppercase letter may be added to the macros defined in the <stdatomic.h> header;
typedef names that begin with either atomic_ or memory_, and a lowercase letter may be added to the declarations in the <stdatomic.h> header;
enumeration constants that begin with memory_order_ and a lowercase letter may be added to the definition of the memory_order type in the <stdatomic.h> header;
function names that begin with atomic_ and a lowercase letter may be added to the declarations in the <stdatomic.h> header.
Identifiers reserved for functions names are always potentially (since C23) reserved for use as identifiers with external linkage, while other identifiers list here are potentially (since C23) reserved when <stdatomic.h> is included.

Declaring, defining, or #undefing such an identifier results in undefined behavior if it is provided by the standard or implementation (since C23). Portable programs should not use those identifiers.

