// RUN: %clam -O0 --crab-inter --crab-dom=zones --crab-check=assert "%s" 2>&1 | OutputCheck %s
// CHECK: ^3  Number of total safe checks$

#include "clam/clam.h"

/* 
 * Basic example with zones.
*/

int f1(int x, int y) {
  if (y > 0) {
    return x + 5;
  } else {
    return x + 10;
  }
}

int f2(int x, int y) {
  if (y > 0) {
    __CRAB_assert(x > 0);
    return 2 + f1(x, y);
  } else {
    return 1 + f1(x, y);
  }
}

int main() {
  int x = nd_int();
  __CRAB_assume(x > 0);
  int y = nd_int();
  //__CRAB_assume(y > 0);
  
  int z = f2(x, y);
  
  __CRAB_assert(z >= x + 6);
  __CRAB_assert(z <= x + 12);
  
  return 0;
}
