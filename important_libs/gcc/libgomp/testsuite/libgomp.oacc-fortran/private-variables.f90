! Miscellaneous tests for private variables.

! { dg-do run }

! { dg-additional-options "-fopt-info-note-omp" }
! { dg-additional-options "--param=openacc-privatization=noisy" }
! { dg-additional-options "-foffload=-fopt-info-note-omp" }
! { dg-additional-options "-foffload=--param=openacc-privatization=noisy" }
! for testing/documenting aspects of that functionality.

! { dg-additional-options "-Wopenacc-parallelism" } for testing/documenting
! aspects of that functionality.

! It's only with Tcl 8.5 (released in 2007) that "the variable 'varName'
! passed to 'incr' may be unset, and in that case, it will be set to [...]",
! so to maintain compatibility with earlier Tcl releases, we manually
! initialize counter variables:
! { dg-line l_dummy[variable c_loop 0] }
! { dg-message "dummy" "" { target iN-VAl-Id } l_dummy } to avoid
! "WARNING: dg-line var l_dummy defined, but not used".


! Test of gang-private variables declared on loop directive.

subroutine t1()
  integer :: x, i, arr(32)

  do i = 1, 32
     arr(i) = i
  end do

  !$acc parallel copy(arr) num_gangs(32) num_workers(8) vector_length(32)
  ! { dg-warning "region is worker partitioned but does not contain worker partitioned code" "" { target *-*-* } .-1 }
  ! { dg-warning "region is vector partitioned but does not contain vector partitioned code" "" { target *-*-* } .-2 }
  !$acc loop gang private(x) ! { dg-line l_loop[incr c_loop] }
  ! { dg-note {variable 'i' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
  ! { dg-note {variable 'x' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
  do i = 1, 32
     x = i * 2;
     arr(i) = arr(i) + x
  end do
  !$acc end parallel

  do i = 1, 32
     if (arr(i) .ne. i * 3) STOP 1
  end do
end subroutine t1


! Test of gang-private variables declared on loop directive, with broadcasting
! to partitioned workers.

subroutine t2()
  integer :: x, i, j, arr(0:32*32)

  do i = 0, 32*32-1
     arr(i) = i
  end do

  !$acc parallel copy(arr) num_gangs(32) num_workers(8) vector_length(32)
  ! { dg-warning "region is vector partitioned but does not contain vector partitioned code" "" { target *-*-* } .-1 }
  !$acc loop gang private(x) ! { dg-line l_loop[incr c_loop] }
  ! { dg-note {variable 'i' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
  ! { dg-note {variable 'x' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
  do i = 0, 31
     x = i * 2;

     !$acc loop worker ! { dg-line l_loop[incr c_loop] }
     ! { dg-note {variable 'j' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     do j = 0, 31
        arr(i * 32 + j) = arr(i * 32 + j) + x
     end do
  end do
  !$acc end parallel

  do i = 0, 32 * 32 - 1
     if (arr(i) .ne. i + (i / 32) * 2) STOP 2
  end do
end subroutine t2


! Test of gang-private variables declared on loop directive, with broadcasting
! to partitioned vectors.

subroutine t3()
  integer :: x, i, j, arr(0:32*32)

  do i = 0, 32*32-1
     arr(i) = i
  end do

  !$acc parallel copy(arr) num_gangs(32) num_workers(8) vector_length(32)
  ! { dg-warning "region is worker partitioned but does not contain worker partitioned code" "" { target *-*-* } .-1 }
  !$acc loop gang private(x) ! { dg-line l_loop[incr c_loop] }
  ! { dg-note {variable 'i' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
  ! { dg-note {variable 'x' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
  do i = 0, 31
     x = i * 2;

     !$acc loop vector ! { dg-line l_loop[incr c_loop] }
     ! { dg-note {variable 'j' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     do j = 0, 31
        arr(i * 32 + j) = arr(i * 32 + j) + x
     end do
  end do
  !$acc end parallel

  do i = 0, 32 * 32 - 1
     if (arr(i) .ne. i + (i / 32) * 2) STOP 3
  end do
end subroutine t3


! Test of gang-private addressable variable declared on loop directive, with
! broadcasting to partitioned workers.

subroutine t4()
  type vec3
     integer x, y, z, attr(13)
  end type vec3

  integer i, j, arr(0:32*32)
  type(vec3) pt
  
  do i = 0, 32*32-1
     arr(i) = i
  end do

  !$acc parallel copy(arr) num_gangs(32) num_workers(8) vector_length(32)
  ! { dg-warning "region is worker partitioned but does not contain worker partitioned code" "" { target *-*-* } .-1 }
  !$acc loop gang private(pt) ! { dg-line l_loop[incr c_loop] }
  ! { dg-note {variable 'i' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
  ! { dg-note {variable 'pt' in 'private' clause is candidate for adjusting OpenACC privatization level} "" { target *-*-* } l_loop$c_loop }
  ! But, with optimizations enabled, per the '*.ssa' dump ('gcc/tree-ssa.c:execute_update_addresses_taken'):
  !     No longer having address taken: pt
  ! However, 'pt' remains in the candidate set:
  ! { dg-note {variable 'pt' ought to be adjusted for OpenACC privatization level: 'gang'} "" { target *-*-* } l_loop$c_loop }
  ! Now, for GCN offloading, 'adjust_private_decl' does the privatization change right away:
  ! { dg-note {variable 'pt' adjusted for OpenACC privatization level: 'gang'} "" { target openacc_radeon_accel_selected } l_loop$c_loop }
  ! For nvptx offloading however, we first mark up 'pt', and then later apply the privatization change -- or, with optimizations enabled, don't, because we then don't actually call 'expand_var_decl'.
  ! { dg-note {variable 'pt' adjusted for OpenACC privatization level: 'gang'} "" { target { openacc_nvidia_accel_selected && { ! __OPTIMIZE__ } } } l_loop$c_loop }
  ! { dg-bogus {note: variable 'pt' adjusted for OpenACC privatization level: 'gang'} "" { target { openacc_nvidia_accel_selected && __OPTIMIZE__ } } l_loop$c_loop }
  do i = 0, 31
     pt%x = i
     pt%y = i * 2
     pt%z = i * 4
     pt%attr(5) = i * 6

     !$acc loop vector ! { dg-line l_loop[incr c_loop] }
     ! { dg-note {variable 'j' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     do j = 0, 31
        arr(i * 32 + j) = arr(i * 32 + j) + pt%x + pt%y + pt%z + pt%attr(5);
     end do
  end do
  !$acc end parallel

  do i = 0, 32 * 32 - 1
     if (arr(i) .ne. i + (i / 32) * 13) STOP 4
  end do
end subroutine t4


! Test of vector-private variables declared on loop directive.

subroutine t5()
  integer :: x, i, j, k, idx, arr(0:32*32*32)

  do i = 0, 32*32*32-1
     arr(i) = i
  end do

  !$acc parallel copy(arr) num_gangs(32) num_workers(8) vector_length(32)
  !$acc loop gang ! { dg-line l_loop[incr c_loop] }
  ! { dg-note {variable 'i' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
  do i = 0, 31
     !$acc loop worker ! { dg-line l_loop[incr c_loop] }
     ! { dg-note {variable 'j' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     do j = 0, 31
        !$acc loop vector private(x) ! { dg-line l_loop[incr c_loop] }
        ! { dg-note {variable 'k' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
        ! { dg-note {variable 'x' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
        do k = 0, 31
           x = ieor(i, j * 3)
           arr(i * 1024 + j * 32 + k) = arr(i * 1024 + j * 32 + k) + x * k
        end do
        !$acc loop vector private(x) ! { dg-line l_loop[incr c_loop] }
        ! { dg-note {variable 'k' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
        ! { dg-note {variable 'x' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
        do k = 0, 31
           x = ior(i, j * 5)
           arr(i * 1024 + j * 32 + k) = arr(i * 1024 + j * 32 + k) + x * k
        end do
     end do
  end do
  !$acc end parallel

  do i = 0, 32 - 1
     do j = 0, 32 -1
        do k = 0, 32 - 1
           idx = i * 1024 + j * 32 + k
           if (arr(idx) .ne. idx + ieor(i, j * 3) * k + ior(i, j * 5) * k) then
              STOP 5
           end if
        end do
     end do
  end do
end subroutine t5


! Test of vector-private variables declared on loop directive. Array type.

subroutine t6()
  integer :: i, j, k, idx, arr(0:32*32*32), pt(2)

  do i = 0, 32*32*32-1
     arr(i) = i
  end do

  !$acc parallel copy(arr) num_gangs(32) num_workers(8) vector_length(32)
  !$acc loop gang ! { dg-line l_loop[incr c_loop] }
  ! { dg-note {variable 'i' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
  do i = 0, 31
     !$acc loop worker ! { dg-line l_loop[incr c_loop] }
     ! { dg-note {variable 'j' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     do j = 0, 31
        !$acc loop vector private(x, pt) ! { dg-line l_loop[incr c_loop] }
        ! { dg-note {variable 'k' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
        ! { dg-bogus {note: variable 'x' in 'private' clause} "" { target *-*-* } l_loop$c_loop }
        ! { dg-note {variable 'pt' in 'private' clause is candidate for adjusting OpenACC privatization level} "" { target *-*-* } l_loop$c_loop }
        ! { dg-note {variable 'pt' ought to be adjusted for OpenACC privatization level: 'vector'} "" { target *-*-* } l_loop$c_loop }
        ! { dg-note {variable 'pt' adjusted for OpenACC privatization level: 'vector'} "" { target { ! openacc_host_selected } } l_loop$c_loop }
        do k = 0, 31
           pt(1) = ieor(i, j * 3)
           pt(2) = ior(i, j * 5)
           arr(i * 1024 + j * 32 + k) = arr(i * 1024 + j * 32 + k) + pt(1) * k
           arr(i * 1024 + j * 32 + k) = arr(i * 1024 + j * 32 + k) + pt(2) * k
        end do
     end do
  end do
  !$acc end parallel

  do i = 0, 32 - 1
     do j = 0, 32 -1
        do k = 0, 32 - 1
           idx = i * 1024 + j * 32 + k
           if (arr(idx) .ne. idx + ieor(i, j * 3) * k + ior(i, j * 5) * k) then
              STOP 6
           end if
        end do
     end do
  end do
end subroutine t6


! Test of worker-private variables declared on a loop directive.

subroutine t7()
  integer :: x, i, j, arr(0:32*32)
  common x

  do i = 0, 32*32-1
     arr(i) = i
  end do

  !$acc parallel copy(arr) num_gangs(32) num_workers(8) vector_length(32)
  ! { dg-warning "region is vector partitioned but does not contain vector partitioned code" "" { target *-*-* } .-1 }
  !$acc loop gang private(x) ! { dg-line l_loop[incr c_loop] }
  ! { dg-note {variable 'i' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
  ! { dg-bogus {note: variable 'x' in 'private' clause} "" { target *-*-* } l_loop$c_loop }
  do i = 0, 31
     !$acc loop worker private(x) ! { dg-line l_loop[incr c_loop] }
     ! { dg-note {variable 'j' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     ! { dg-note {variable 'x' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     do j = 0, 31
        x = ieor(i, j * 3)
        arr(i * 32 + j) = arr(i * 32 + j) + x
     end do
  end do
  !$acc end parallel

  do i = 0, 32 * 32 - 1
     if (arr(i) .ne. i + ieor(i / 32, mod(i, 32) * 3)) STOP 7
  end do
end subroutine t7


! Test of worker-private variables declared on a loop directive, broadcasting
! to vector-partitioned mode.

subroutine t8()
  integer :: x, i, j, k, idx, arr(0:32*32*32)

  do i = 0, 32*32*32-1
     arr(i) = i
  end do

  !$acc parallel copy(arr) num_gangs(32) num_workers(8) vector_length(32)
  !$acc loop gang ! { dg-line l_loop[incr c_loop] }
  ! { dg-note {variable 'i' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
  do i = 0, 31
     !$acc loop worker private(x) ! { dg-line l_loop[incr c_loop] }
     ! { dg-note {variable 'j' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     ! { dg-note {variable 'x' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     do j = 0, 31
        x = ieor(i, j * 3)

        !$acc loop vector ! { dg-line l_loop[incr c_loop] }
        ! { dg-note {variable 'k' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
        do k = 0, 31
           arr(i * 1024 + j * 32 + k) = arr(i * 1024 + j * 32 + k) + x * k
        end do
     end do
  end do
  !$acc end parallel

  do i = 0, 32 - 1
     do j = 0, 32 -1
        do k = 0, 32 - 1
           idx = i * 1024 + j * 32 + k
           if (arr(idx) .ne. idx + ieor(i, j * 3) * k) STOP 8
        end do
     end do
  end do
end subroutine t8


! Test of worker-private variables declared on a loop directive, broadcasting
! to vector-partitioned mode.  Back-to-back worker loops.

subroutine t9()
  integer :: x, i, j, k, idx, arr(0:32*32*32)

  do i = 0, 32*32*32-1
     arr(i) = i
  end do

  !$acc parallel copy(arr) num_gangs(32) num_workers(8) vector_length(32)
  !$acc loop gang ! { dg-line l_loop[incr c_loop] }
  ! { dg-note {variable 'i' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
  do i = 0, 31
     !$acc loop worker private(x) ! { dg-line l_loop[incr c_loop] }
     ! { dg-note {variable 'j' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     ! { dg-note {variable 'x' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     do j = 0, 31
        x = ieor(i, j * 3)

        !$acc loop vector ! { dg-line l_loop[incr c_loop] }
        ! { dg-note {variable 'k' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
        do k = 0, 31
           arr(i * 1024 + j * 32 + k) = arr(i * 1024 + j * 32 + k) + x * k
        end do
     end do

     !$acc loop worker private(x) ! { dg-line l_loop[incr c_loop] }
     ! { dg-note {variable 'j' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     ! { dg-note {variable 'x' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     do j = 0, 31
        x = ior(i, j * 5)

        !$acc loop vector ! { dg-line l_loop[incr c_loop] }
        ! { dg-note {variable 'k' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
        do k = 0, 31
           arr(i * 1024 + j * 32 + k) = arr(i * 1024 + j * 32 + k) + x * k
        end do
     end do
  end do
  !$acc end parallel

  do i = 0, 32 - 1
     do j = 0, 32 -1
        do k = 0, 32 - 1
           idx = i * 1024 + j * 32 + k
           if (arr(idx) .ne. idx + ieor(i, j * 3) * k + ior(i, j * 5) * k) then
              STOP 9
           end if
        end do
     end do
  end do
end subroutine t9


! Test of worker-private variables declared on a loop directive, broadcasting
! to vector-partitioned mode.  Successive vector loops.  */

subroutine t10()
  integer :: x, i, j, k, idx, arr(0:32*32*32)

  do i = 0, 32*32*32-1
     arr(i) = i
  end do

  !$acc parallel copy(arr) num_gangs(32) num_workers(8) vector_length(32)
  !$acc loop gang ! { dg-line l_loop[incr c_loop] }
  ! { dg-note {variable 'i' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
  do i = 0, 31
     !$acc loop worker private(x) ! { dg-line l_loop[incr c_loop] }
     ! { dg-note {variable 'j' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     ! { dg-note {variable 'x' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     do j = 0, 31
        x = ieor(i, j * 3)

        !$acc loop vector ! { dg-line l_loop[incr c_loop] }
        ! { dg-note {variable 'k' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
        do k = 0, 31
           arr(i * 1024 + j * 32 + k) = arr(i * 1024 + j * 32 + k) + x * k
        end do

        x = ior(i, j * 5)

        !$acc loop vector ! { dg-line l_loop[incr c_loop] }
        ! { dg-note {variable 'k' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
        do k = 0, 31
           arr(i * 1024 + j * 32 + k) = arr(i * 1024 + j * 32 + k) + x * k
        end do
     end do
  end do
  !$acc end parallel

  do i = 0, 32 - 1
     do j = 0, 32 -1
        do k = 0, 32 - 1
           idx = i * 1024 + j * 32 + k
           if (arr(idx) .ne. idx + ieor(i, j * 3) * k + ior(i, j * 5) * k) then
              STOP 10
           end if
        end do
     end do
  end do
end subroutine t10


! Test of worker-private variables declared on a loop directive, broadcasting
! to vector-partitioned mode.  Addressable worker variable.

subroutine t11()
  integer :: i, j, k, idx, arr(0:32*32*32)
  integer, target :: x
  integer, pointer :: p

  do i = 0, 32*32*32-1
     arr(i) = i
  end do

  !$acc parallel copy(arr) num_gangs(32) num_workers(8) vector_length(32)
  !$acc loop gang ! { dg-line l_loop[incr c_loop] }
  ! { dg-note {variable 'i' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
  do i = 0, 31
     !$acc loop worker private(x, p) ! { dg-line l_loop[incr c_loop] }
     ! { dg-note {variable 'j' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     ! { dg-note {variable 'x' in 'private' clause is candidate for adjusting OpenACC privatization level} "" { target *-*-* } l_loop$c_loop }
     ! { dg-note {variable 'x' ought to be adjusted for OpenACC privatization level: 'worker'} "" { target *-*-* } l_loop$c_loop }
     ! { dg-note {variable 'x' adjusted for OpenACC privatization level: 'worker'} "TODO" { target { ! openacc_host_selected } xfail *-*-* } l_loop$c_loop }
     ! { dg-note {variable 'p' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     do j = 0, 31
        p => x
        x = ieor(i, j * 3)

        !$acc loop vector ! { dg-line l_loop[incr c_loop] }
        ! { dg-note {variable 'k' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
        do k = 0, 31
           arr(i * 1024 + j * 32 + k) = arr(i * 1024 + j * 32 + k) + x * k
        end do

        p = ior(i, j * 5)

        !$acc loop vector ! { dg-line l_loop[incr c_loop] }
        ! { dg-note {variable 'k' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
        do k = 0, 31
           arr(i * 1024 + j * 32 + k) = arr(i * 1024 + j * 32 + k) + x * k
        end do
     end do
  end do
  !$acc end parallel

  do i = 0, 32 - 1
     do j = 0, 32 -1
        do k = 0, 32 - 1
           idx = i * 1024 + j * 32 + k
           if (arr(idx) .ne. idx + ieor(i, j * 3) * k + ior(i, j * 5) * k) then
              STOP 11
           end if
        end do
     end do
  end do
end subroutine t11


! Test of worker-private variables declared on a loop directive, broadcasting
! to vector-partitioned mode.  Aggregate worker variable.

subroutine t12()
  type vec2
     integer x, y
  end type vec2
  
  integer :: i, j, k, idx, arr(0:32*32*32)
  type(vec2) :: pt
  
  do i = 0, 32*32*32-1
     arr(i) = i
  end do

  !$acc parallel copy(arr) num_gangs(32) num_workers(8) vector_length(32)
  !$acc loop gang ! { dg-line l_loop[incr c_loop] }
  ! { dg-note {variable 'i' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
  do i = 0, 31
     !$acc loop worker private(pt) ! { dg-line l_loop[incr c_loop] }
     ! { dg-note {variable 'j' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     ! { dg-note {variable 'pt' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     do j = 0, 31
        pt%x = ieor(i, j * 3)
        pt%y = ior(i, j * 5)
        
        !$acc loop vector ! { dg-line l_loop[incr c_loop] }
        ! { dg-note {variable 'k' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
        do k = 0, 31
           arr(i * 1024 + j * 32 + k) = arr(i * 1024 + j * 32 + k) + pt%x * k
        end do

        !$acc loop vector ! { dg-line l_loop[incr c_loop] }
        ! { dg-note {variable 'k' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
        do k = 0, 31
           arr(i * 1024 + j * 32 + k) = arr(i * 1024 + j * 32 + k) + pt%y * k
        end do
     end do
  end do
  !$acc end parallel

  do i = 0, 32 - 1
     do j = 0, 32 -1
        do k = 0, 32 - 1
           idx = i * 1024 + j * 32 + k
           if (arr(idx) .ne. idx + ieor(i, j * 3) * k + ior(i, j * 5) * k) then
              STOP 12
           end if
        end do
     end do
  end do
end subroutine t12


! Test of worker-private variables declared on loop directive, broadcasting
! to vector-partitioned mode.  Array worker variable.

subroutine t13()
  integer :: i, j, k, idx, arr(0:32*32*32), pt(2)

  do i = 0, 32*32*32-1
     arr(i) = i
  end do

  !$acc parallel copy(arr) num_gangs(32) num_workers(8) vector_length(32)
  !$acc loop gang ! { dg-line l_loop[incr c_loop] }
  ! { dg-note {variable 'i' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
  do i = 0, 31
     !$acc loop worker private(pt) ! { dg-line l_loop[incr c_loop] }
     ! { dg-note {variable 'j' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
     ! { dg-note {variable 'pt' in 'private' clause is candidate for adjusting OpenACC privatization level} "" { target *-*-* } l_loop$c_loop }
     ! { dg-note {variable 'pt' ought to be adjusted for OpenACC privatization level: 'worker'} "" { target *-*-* } l_loop$c_loop }
     ! { dg-note {variable 'pt' adjusted for OpenACC privatization level: 'worker'} "TODO" { target { ! openacc_host_selected } xfail *-*-* } l_loop$c_loop } */
     do j = 0, 31
        pt(1) = ieor(i, j * 3)
        pt(2) = ior(i, j * 5)
        
        !$acc loop vector ! { dg-line l_loop[incr c_loop] }
        ! { dg-note {variable 'k' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
        do k = 0, 31
           arr(i * 1024 + j * 32 + k) = arr(i * 1024 + j * 32 + k) + pt(1) * k
        end do

        !$acc loop vector ! { dg-line l_loop[incr c_loop] }
        ! { dg-note {variable 'k' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
        do k = 0, 31
           arr(i * 1024 + j * 32 + k) = arr(i * 1024 + j * 32 + k) + pt(2) * k
        end do
     end do
  end do
  !$acc end parallel

  do i = 0, 32 - 1
     do j = 0, 32 -1
        do k = 0, 32 - 1
           idx = i * 1024 + j * 32 + k
           if (arr(idx) .ne. idx + ieor(i, j * 3) * k + ior(i, j * 5) * k) then
              STOP 13
           end if
        end do
     end do
  end do
end subroutine t13


! Test of gang-private variables declared on the parallel directive.

subroutine t14()
  use openacc
  integer :: x = 5
  integer, parameter :: n = 32
  integer :: arr(n)

  do i = 1, n
    arr(i) = 3
  end do

  !$acc parallel private(x) copy(arr) num_gangs(n) num_workers(8) vector_length(32)
  ! { dg-warning "region is worker partitioned but does not contain worker partitioned code" "" { target *-*-* } .-1 }
  ! { dg-warning "region is vector partitioned but does not contain vector partitioned code" "" { target *-*-* } .-2 }
    !$acc loop gang(static:1) ! { dg-line l_loop[incr c_loop] }
    ! { dg-note {variable 'i' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
    do i = 1, n
      x = i * 2;
    end do

   !$acc loop gang(static:1) ! { dg-line l_loop[incr c_loop] }
    ! { dg-note {variable 'i' in 'private' clause isn't candidate for adjusting OpenACC privatization level: not addressable} "" { target *-*-* } l_loop$c_loop }
    do i = 1, n
       ! { dg-note {variable 'C\.[0-9]+' declared in block potentially has improper OpenACC privatization level: 'const_decl'} "TODO" { target *-*-* } l_loop$c_loop }
       !TODO Unhandled 'CONST_DECL' instance for constant argument in 'acc_on_device' call.
      if (acc_on_device (acc_device_host) .eqv. .TRUE.) x = i * 2
      arr(i) = arr(i) + x
    end do
  !$acc end parallel

  do i = 1, n
    if (arr(i) .ne. (3 + i * 2)) STOP 14
  end do

end subroutine t14


program main
  call t1()
  call t2()
  call t3()
  call t4()
  call t5()
  call t6()
  call t7()
  call t8()
  call t9()
  call t10()
  call t11()
  call t12()
  call t13()
  call t14()
end program main
