/* { dg-do link { target { offload_target_nvptx } } } */
/* { dg-additional-options "-foffload=-misa=sm_75 -foffload=-mptx=_" } */
/* { dg-additional-options "-foffload=-fdump-tree-optimized" } */

#include "declare-variant-3.h"

/* { dg-final { scan-offload-tree-dump "= f75 \\(\\);" "optimized" } } */
