Atomic operations
Defined in header <stdatomic.h>
Operations on atomic types
ATOMIC_BOOL_LOCK_FREE
ATOMIC_CHAR_LOCK_FREE
ATOMIC_CHAR16_T_LOCK_FREE
ATOMIC_CHAR32_T_LOCK_FREE
ATOMIC_WCHAR_T_LOCK_FREE
ATOMIC_SHORT_LOCK_FREE
ATOMIC_INT_LOCK_FREE
ATOMIC_LONG_LOCK_FREE
ATOMIC_LLONG_LOCK_FREE
ATOMIC_POINTER_LOCK_FREE
  
(C11)
 
indicates that the given atomic type is lock-free
(macro constant)
atomic_is_lock_free
  
(C11)
 
indicates whether the atomic object is lock-free
(function)
atomic_store
atomic_store_explicit
  
(C11)
 
stores a value in an atomic object
(function)
atomic_load
atomic_load_explicit
  
(C11)
 
reads a value from an atomic object
(function)
atomic_exchange
atomic_exchange_explicit
  
(C11)
 
swaps a value with the value of an atomic object
(function)
atomic_compare_exchange_strong
atomic_compare_exchange_strong_explicit
atomic_compare_exchange_weak
atomic_compare_exchange_weak_explicit
  
(C11)
 
swaps a value with an atomic object if the old value is what is expected, otherwise reads the old value
(function)
atomic_fetch_add
atomic_fetch_add_explicit
  
(C11)
 
atomic addition
(function)
atomic_fetch_sub
atomic_fetch_sub_explicit
  
(C11)
 
atomic subtraction
(function)
atomic_fetch_or
atomic_fetch_or_explicit
  
(C11)
 
atomic bitwise OR
(function)
atomic_fetch_xor
atomic_fetch_xor_explicit
  
(C11)
 
atomic bitwise exclusive OR
(function)
atomic_fetch_and
atomic_fetch_and_explicit
  
(C11)
 
atomic bitwise AND
(function)
Flag type and operations
atomic_flag
  
(C11)
 
lock-free atomic boolean flag
(struct)
atomic_flag_test_and_set
atomic_flag_test_and_set_explicit
  
(C11)
 
sets an atomic_flag to true and returns the old value
(function)
atomic_flag_clear
atomic_flag_clear_explicit
  
(C11)
 
sets an atomic_flag to false
(function)
Initialization
atomic_init
  
(C11)
 
initializes an existing atomic object
(function)
ATOMIC_VAR_INIT
  
(C11)(deprecated in C17)(removed in C23)
 
initializes a new atomic object
(function macro)
ATOMIC_FLAG_INIT
  
(C11)
 
initializes a new atomic_flag
(macro constant)
Memory synchronization ordering
memory_order
  
(C11)
 
defines memory ordering constraints
(enum)
kill_dependency
  
(C11)
 
breaks a dependency chain for memory_order_consume
(function macro)
atomic_thread_fence
  
(C11)
 
generic memory order-dependent fence synchronization primitive
(function)
atomic_signal_fence
  
(C11)
 
fence between a thread and a signal handler executed in the same thread
(function)
Convenience type aliases
Typedef name	Full type name
atomic_bool(C11)	_Atomic _Bool
atomic_char(C11)	_Atomic char
atomic_schar(C11)	_Atomic signed char
atomic_uchar(C11)	_Atomic unsigned char
atomic_short(C11)	_Atomic short
atomic_ushort(C11)	_Atomic unsigned short
atomic_int(C11)	_Atomic int
atomic_uint(C11)	_Atomic unsigned int
atomic_long(C11)	_Atomic long
atomic_ulong(C11)	_Atomic unsigned long
atomic_llong(C11)	_Atomic long long
atomic_ullong(C11)	_Atomic unsigned long long
atomic_char8_t(C23)	_Atomic char8_t
atomic_char16_t(C11)	_Atomic char16_t
atomic_char32_t(C11)	_Atomic char32_t
atomic_wchar_t(C11)	_Atomic wchar_t
atomic_int_least8_t(C11)	_Atomic int_least8_t
atomic_uint_least8_t(C11)	_Atomic uint_least8_t
atomic_int_least16_t(C11)	_Atomic int_least16_t
atomic_uint_least16_t(C11)	_Atomic uint_least16_t
atomic_int_least32_t(C11)	_Atomic int_least32_t
atomic_uint_least32_t(C11)	_Atomic uint_least32_t
atomic_int_least64_t(C11)	_Atomic int_least64_t
atomic_uint_least64_t(C11)	_Atomic uint_least64_t
atomic_int_fast8_t(C11)	_Atomic int_fast8_t
atomic_uint_fast8_t(C11)	_Atomic uint_fast8_t
atomic_int_fast16_t(C11)	_Atomic int_fast16_t
atomic_uint_fast16_t(C11)	_Atomic uint_fast16_t
atomic_int_fast32_t(C11)	_Atomic int_fast32_t
atomic_uint_fast32_t(C11)	_Atomic uint_fast32_t
atomic_int_fast64_t(C11)	_Atomic int_fast64_t
atomic_uint_fast64_t(C11)	_Atomic uint_fast64_t
atomic_intptr_t(C11)	_Atomic intptr_t
atomic_uintptr_t(C11)	_Atomic uintptr_t
atomic_size_t(C11)	_Atomic size_t
atomic_ptrdiff_t(C11)	_Atomic ptrdiff_t
atomic_intmax_t(C11)	_Atomic intmax_t
atomic_uintmax_t(C11)	_Atomic uintmax_t
