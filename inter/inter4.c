// RUN: %clam -O0 --crab-inter --crab-inter-recursive-functions --crab-dom=zones --crab-check=assert "%s" 2>&1 | OutputCheck %s
// CHECK: ^2  Number of total safe checks$

extern int int_nd(void);
extern void __CRAB_assert(int);
extern void __CRAB_assume(int);


// Example of simple recursive function

int foo(int x) {
  if (x > 0) {
    return 1 + foo(x-1);
  } else {
    return x;
  }
}

int main () {

  int x1 = int_nd();
  int y1 = foo(x1);
  __CRAB_assert(y1 == x1);

  int x2 = 1000;
  int y2 = foo(x2);
  __CRAB_assert(y2 == 1000);
  
  return 0;
}
