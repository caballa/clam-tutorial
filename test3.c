// RUN: %clam -O0 --crab-inter --crab-dom=int --llvm-peel-loops=1 --crab-track=mem --crab-heap-analysis=cs-sea-dsa --crab-check=assert "%s" 2>&1 | OutputCheck %s
// CHECK: ^2  Number of total safe checks$

/*
  Example where tracking of memory contents is required
 */

#include <stdlib.h>

extern int int_nd(void);
extern void __CRAB_assume(int);
extern void __CRAB_assert(int);

int* init(int sz) {
  return (int*)malloc(sz*sizeof(int));
}

int main () {
  int n = int_nd();
  __CRAB_assume(n>0);

  int* a = init(n);

  int i;
  for (i=0;i<n;i++) {
    a[i] = (int_nd() ? 0 : 1);
  }
  
  int j = int_nd();
  __CRAB_assume(j>=0);
  __CRAB_assume(j<n);

  int z = a[j];
  __CRAB_assert(z >= 0);
  __CRAB_assert(z <= 1);
  
  return 0;
}
