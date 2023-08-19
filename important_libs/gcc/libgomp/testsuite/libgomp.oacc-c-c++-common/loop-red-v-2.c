/* { dg-additional-options "-fopt-info-note-omp" }
   { dg-additional-options "--param=openacc-privatization=noisy" }
   { dg-additional-options "-foffload=-fopt-info-note-omp" }
   { dg-additional-options "-foffload=--param=openacc-privatization=noisy" }
   for testing/documenting aspects of that functionality.  */

#include <stdio.h>
#include <openacc.h>
#include <gomp-constants.h>

#define N (32*32*32+17)

int main ()
{
  int ix;
  int ondev = 0;
  int q = 0,  h = 0;
  int vectorsize;

#define VL 32
#pragma acc parallel vector_length(VL) copy(q) copy(ondev)
  /* { dg-note {variable 't' declared in block isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } .-1 } */
  /* { dg-note {variable 'ix' declared in block isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } .-2 } */
  {
    int t = q;
    
#pragma acc loop vector reduction (+:t)
    /* { dg-note {variable 'ix' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } .-1 } */
    /* { dg-note {variable 'val' declared in block isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } .-2 } */
    /* { dg-note {variable 'g' declared in block isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } .-3 } */
    /* { dg-note {variable 'w' declared in block isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } .-4 } */
    /* { dg-note {variable 'v' declared in block isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } .-5 } */
    for (unsigned ix = 0; ix < N; ix++)
      {
	int val = ix;
	
	if (acc_on_device (acc_device_not_host))
	  {
	    int g, w, v;

	    g = __builtin_goacc_parlevel_id (GOMP_DIM_GANG);
	    w = __builtin_goacc_parlevel_id (GOMP_DIM_WORKER);
	    v = __builtin_goacc_parlevel_id (GOMP_DIM_VECTOR);
	    val = (g << 16) | (w << 8) | v;
	    ondev = 1;
	  }
	t += val;
      }
    q = t;
  }
  vectorsize = VL;
#ifdef ACC_DEVICE_TYPE_radeon
  /* AMD GCN uses the autovectorizer for the vector dimension: the use
     of a function call in vector-partitioned code in this test is not
     currently supported.  */
  vectorsize = 1;
#endif

  for (ix = 0; ix < N; ix++)
    {
      int val = ix;
      if (ondev)
	{
	  int g = 0;
	  int w = 0;
	  int v = ix % vectorsize;

	  val = (g << 16) | (w << 8) | v;
	}
      h += val;
    }

  if (q != h)
    {
      printf ("t=%x expected %x\n", q, h);
      return 1;
    }
  
  return 0;
}
