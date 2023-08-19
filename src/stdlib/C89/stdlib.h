Defined in header <stdlib.h>
atof
 
converts a byte string to a floating-point value
(function)
atoi
atol
atoll
  
(C99)
 
converts a byte string to an integer value
(function)
strtol
strtoll
  
(C99)
 
converts a byte string to an integer value
(function)
strtoul
strtoull
  
(C99)
 
converts a byte string to an unsigned integer value
(function)
strtof
strtod
strtold
  
(C99)
(C99)
 
converts a byte string to a floating point value
(function)
strfromf
strfromd
strfromld
  
(C23)
(C23)
(C23)
 
converts a floating point value to a byte string
(function)



Common mathematical functions
 C Numerics Common mathematical functions 
Functions
Defined in header <stdlib.h>
abs
labs
llabs
  
(C99)
 
computes absolute value of an integral value (
|
x
|
)
(function)
div
ldiv
lldiv
  
(C99)
 
computes quotient and remainder of integer division
(function)
Defined in header <inttypes.h>
imaxabs
  
(C99)
 
computes absolute value of an integral value (
|
x
|
)
(function)
imaxdiv
  
(C99)
 
computes quotient and remainder of integer division
(function)










Program termination
The following functions manage program termination and resources cleanup.

Defined in header <stdlib.h>
abort
 
causes abnormal program termination (without cleaning up)
(function)
exit
 
causes normal program termination with cleaning up
(function)
quick_exit
  
(C11)
 
causes normal program termination without completely cleaning up
(function)
_Exit
  
(C99)
 
causes normal program termination without cleaning up
(function)
atexit
 
registers a function to be called on exit() invocation
(function)
at_quick_exit
  
(C11)
 
registers a function to be called on quick_exit invocation
(function)
EXIT_SUCCESS
EXIT_FAILURE
 
indicates program execution execution status
(macro constant)


Communicating with the environment
Defined in header <stdlib.h>
system
 
calls the host environment's command processor
(function)
getenv
getenv_s
  
(C11)
 
access to the list of environment variables
(function)
