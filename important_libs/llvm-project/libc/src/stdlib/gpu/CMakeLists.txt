add_entrypoint_object(
  malloc
  SRCS
    malloc.cpp
  HDRS
    ../malloc.h
  DEPENDS
    libc.include.stdlib
    libc.src.__support.RPC.rpc_client
)

add_entrypoint_object(
  free
  SRCS
    free.cpp
  HDRS
    ../free.h
  DEPENDS
    libc.include.stdlib
    libc.src.__support.RPC.rpc_client
)
