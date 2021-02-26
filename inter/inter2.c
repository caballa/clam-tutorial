// RUN: %clam  --crab-inter --crab-dom=pk --crab-check=assert "%s" 2>&1 | OutputCheck %s
// CHECK: ^3  Number of total safe checks$

/* 
 * More complex example that needs convex polyhedra.
*/

extern int int_nd(void);
extern void __CRAB_assume(int);
extern void __CRAB_assert(int);

int f1(int x, int y) {
  if (int_nd()) {
    return x  + y;
  } else {
    return x + y + 2;
  }
}

int f2(int x, int y) {
  if (y > 0) {
    __CRAB_assert(x >= 0);
    return x + y + f1(x, y);
  } else {
    return x + y + 1 + f1(x, y);
  }
}

int f3(int x, int y) {
  if (int_nd()) {
    __CRAB_assert(x >= 0);
    return x + y + f2(x, y);
  } else {
    return x + y + 1 + f2(x, y);    
  }
}

int main() {
  int x = int_nd();
  int y = int_nd();
  __CRAB_assume(x > 0);
  //__CRAB_assume(y > 0);  
			 
  int z = f3(x, y);
  //__CRAB_assert(z >= 6);  
  __CRAB_assert(z >= 3*(x+y));
  return 0;
}
