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
   - Collections
      - Search Trees
         - Binary tree
         - B-tree
         - B+ tree
         - Trie
         - (a,b)-tree
         - 2–3 tree
         - 2–3–4 tree
         - Red–black tree
         - Splay Tree
         - AVL tree


Reg/Memory:
https://en.wikipedia.org/wiki/Content-addressable_memory


General:
https://en.wikipedia.org/wiki/Abstract_data_type
https://en.wikipedia.org/wiki/Collection_(abstract_data_type)
https://en.wikipedia.org/wiki/In-place_algorithm
https://en.wikipedia.org/wiki/Data_structure
https://en.wikipedia.org/wiki/List_of_data_structures
https://en.wikipedia.org/wiki/Comparison_of_data_structures

Arrays:
https://en.wikipedia.org/wiki/Array_(data_structure)
https://en.wikipedia.org/wiki/Array_(data_type)
https://en.wikipedia.org/wiki/Lookup_table
https://en.wikipedia.org/wiki/Word_(computer_architecture)
https://en.wikipedia.org/wiki/List_(abstract_data_type)
https://en.wikipedia.org/wiki/Statement_(computer_science)
https://en.wikipedia.org/wiki/Bitwise_operation
https://en.wikipedia.org/wiki/Dynamic_array
https://en.wikipedia.org/wiki/Triangular_array

https://www.geeksforgeeks.org/c-arrays/
https://www.geeksforgeeks.org/complete-guide-on-array-rotations/
https://betterprogramming.pub/3-ways-to-rotate-an-array-2a45b39f7bec
https://medium.com/nerd-for-tech/array-rotation-73021cd851dd

Sets:
https://en.wikipedia.org/wiki/Set_(abstract_data_type)

LinkedLists:
https://en.wikipedia.org/wiki/Linked_list

Trees:
https://en.wikipedia.org/wiki/Tree_(data_structure)
https://en.wikipedia.org/wiki/Search_tree
https://en.wikipedia.org/wiki/(a,b)-tree
https://en.wikipedia.org/wiki/2%E2%80%933%E2%80%934_tree
https://en.wikipedia.org/wiki/Red%E2%80%93black_tree
https://en.wikipedia.org/wiki/Self-balancing_binary_search_tree
https://en.wikipedia.org/wiki/Binary_search_tree
https://en.wikipedia.org/wiki/AVL_tree
https://en.wikipedia.org/wiki/Sentinel_node
https://en.wikipedia.org/wiki/Binary_tree
https://en.wikipedia.org/wiki/Tree_traversal
https://en.wikipedia.org/wiki/Join-based_tree_algorithms
https://en.wikipedia.org/wiki/WAVL_tree

Hash Maps:
https://en.wikipedia.org/wiki/Associative_array
https://en.wikipedia.org/wiki/Hash_table
https://en.wikipedia.org/wiki/Comparison_of_programming_languages_(associative_array)
https://en.wikipedia.org/wiki/Associative_containers

https://en.wikipedia.org/wiki/Name%E2%80%93value_pair
https://en.wikipedia.org/wiki/Heap_(data_structure)


https://en.wikipedia.org/wiki/Hash_function


Sorting Algorithms:
https://en.wikipedia.org/wiki/Sorting_algorithm