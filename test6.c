// RUN: %clam -g -O0 --crab-inter --crab-dom=int --crab-track=mem --crab-heap-analysis=cs-sea-dsa --promote-malloc=false --crab-check=uaf "%s" 2>&1 | OutputCheck %s
// CHECK: ^0  Number of total warning checks$

#include <stdlib.h>

extern int int_nd(void);
extern void __CRAB_assert(int);
extern void __CRAB_assume(int);

struct s {
  int* f1;
  int* f2;
};

void del(struct s* p) {
  *(p->f1) = int_nd();
  free(p->f1);
}

void initX(struct s* p) {
  int *x = (int*) malloc(sizeof(int));
  __CRAB_assume(x > 0);    
  if (int_nd()) {
    *x = 5;
  } else {
    *x = 7;
  }
  int *y = (int*) malloc(sizeof(int));
  __CRAB_assume(y > 0);  
  *y = int_nd();
  
  p->f1 = y;
  p->f2 = x;
}

void init(struct s* p) {
  initX(p);
}

void check(struct s* p) {
  __CRAB_assert(*(p->f2) >= 5);
}

int main () {
  struct s *p = (struct s*) malloc(sizeof(struct s));
  __CRAB_assume(p > 0);

  init(p);

  del(p);

  check(p);

  return 0;
}
