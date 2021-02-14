// RUN: %clam -O0 --crab-dom=pk --crab-check=assert "%s" 2>&1 | OutputCheck %s
// CHECK: ^1  Number of total safe checks$
// CHECK: ^0  Number of total error checks$
// CHECK: ^0  Number of total warning checks$


/* 
   Simple example about numerical invariants
   The assertion can be proven by Polyhedra.
 */

extern int nd_int(void);
extern void __CRAB_assume(int);
extern void __CRAB_assert(int);

int main (){

  int x,y,i,n;
  x=0;
  y=0;  
  n=nd_int();

  __CRAB_assume(n >= 0);
  for (i=0;i<n;i++) {
    x = x+1;
    y = y+3;
  }

  __CRAB_assert(y == 3*x);

  return 0;
}
