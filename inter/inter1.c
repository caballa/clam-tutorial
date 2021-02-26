// RUN: %clam -O0 --crab-inter --crab-dom=int --crab-check=assert "%s" 2>&1 | OutputCheck %s
// CHECK: ^3  Number of total safe checks$

/* 
 * Example where top-down interprocedural analysis with intervals is
 * enough.
*/

extern int int_nd(void);
extern void __CRAB_assume(int);
extern void __CRAB_assert(int);

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
  //int x = int_nd();
  //__CRAB_assume(x == 0);
  int x = 0;
  //int y = int_nd();
  //__CRAB_assume(y == 0);
  int y = 0;
  
  int z = f2(x, y);
  
  __CRAB_assert(z >= x + 6);
  __CRAB_assert(z <= x + 12);
  
  return 0;
}
