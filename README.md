# c_base
A base in C - as a workspace to orient my thought process in Rust. 

C Code frags/artifacts to serve as base for capturing concepts,
defaults or expected-or-known behaviors before describing and 
implementing concepts in rust.


Basics:
   - Registers
      - get size
      - get endianess
      - shift based multiplication
      - ones, twos, threes? compliment
      - reg splitting
      - reg joining
      - arbitrary precision operations
      - sys-cntrl:
         - grab/intercept sp, pc, etc... 
         - halt execution
         - start execution
         - change execution at arbitrary points
         - intercept/re-write  inmem/inproc linker tables
   - Arrays
      - split
      - slice
      - shift
      - rotate (left right)
      - reverse
      - copy
      - insert
      - inject (at point insert multi)
      - delete
      - extract (at point, remove multi)
      - length (3: strlen type, end-delimiter, associated struct fnptrs)
      - sort
      - search (s-one, s-n)
      - compare to another array
   - Pointers
      - fn ptrs (correct design/manip with)
      - all ops ptr driven
   - 




https://www.geeksforgeeks.org/c-arrays/
https://www.geeksforgeeks.org/complete-guide-on-array-rotations/
https://betterprogramming.pub/3-ways-to-rotate-an-array-2a45b39f7bec
https://medium.com/nerd-for-tech/array-rotation-73021cd851dd