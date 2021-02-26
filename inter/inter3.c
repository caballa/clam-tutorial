extern int int_nd(void);
extern void __CRAB_assume(int);
extern void __CRAB_assert(int);

// RUN: %clam -O0 --crab-inter --crab-dom=pk --crab-check=assert  --crab-track=sing-mem  "%s" 2>&1 | OutputCheck %s
// CHECK: ^2  Number of total safe checks$

/* 
 * Example with arrays (global variables are translated as arrays) The
 * bottom-up analysis with polyhedra should be able to prove the
 * property but it doesn't. One reason has to do with the transfer
 * function for __array__ assignments in the underlying array
 * domain. Another reason is that in f2 the call to f1 might not be
 * happen so the lack of __disjunctive__ invariants also makes the
 * return value of f2 being less precise.
 * 
 * However, the top-down analysis even with intervals can prove the
 * property.
 */

int x = 2;
int y = 5;

int f1(int a) {
  x+=2;
  y++;
  return a+1;
  // ret=a+1 and  x = x_in + 2 and y = y_in + 1
}

int f2(int a) {
  x++;
  int b=0;
  if (int_nd()) {
    b = f1(a);
  }
  return a+b+1;
  // ret = a + 1   and x = x_in + 1  OR
  // ret = 2*(a+1) and x = x_in + 3 and y = y_in + 1
}


int f3(int a) {
  x+=3;
  return a+3;
  // ret = a+3 and x = x_in + 3
}

int main() {

  int a = 2;
  int b = f2(a);
  //  3 <= b <= 6 and 3 <= x <= 5 and 5 <= y <= 6
  int c = f1(b);
  //  4 <= c <= 7 and 5 <= x <= 7 and 6 <= y <= 7
  int d = f3(c);
  //  7 <= d <= 10 and  8 <= x <= 10 and 6 <= y <= 7

  int z = d + x + y;
  
  __CRAB_assert(z >= 21);
  __CRAB_assert(z <= 27);  
  return 0;
}
