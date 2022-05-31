#include <stdlib.h>

// RUN: %clam --crab-track=mem --crab-check=assert --crab-dom=zones --crab-heap-analysis=cs-sea-dsa --crab-inter    --llvm-peel-loops=1 "%s" 2>&1 | OutputCheck %s
// CHECK: ^10  Number of total safe checks$
// CHECK: ^ 0  Number of total warning checks$

#include "clam/clam.h"

/**
 * Example where tracking of memory contents and pointers are required
 **/

#define CRAB_assert_forall(A, LEN, VAL)		\
  {						\
    int i;					\
    for (i=0; i<LEN;++i) {			\
      __CRAB_assert(A[i] == VAL);		\
    }						\
  }

typedef int SIZE;

typedef struct node{
  int    *data;
  SIZE len;
  SIZE cap;
  struct node *n;
} *List;


#define N 10000
#define M 1024

void* malloc_not_fail(SIZE sz) {
  void* p = malloc(sz);
  __CRAB_assume(p > 0);
  return p;
}

int* mycalloc(SIZE sz) {
  int* data = (int*) malloc_not_fail(sizeof(int) * sz);
  int i;
  for (i=0;i<sz;++i) {
    data[i] = 0;
  }
  return data;
}

List mk_list(int n, SIZE data_sz) {
  List l = 0;
  int i;
  for (i=0; i<n;i++) {
    List tmp = (List) malloc_not_fail(sizeof(struct node));    
    int* data = mycalloc(data_sz); 
    tmp->data= data;
    tmp->cap = data_sz;
    int used = nd_int();
    __CRAB_assume(used >= 0);
    __CRAB_assume(used < data_sz);
    tmp->len = used;
    tmp->n = l ;
    l = tmp;
  }
  return l;
}

// (1) every node n. n->data is not null
// (2) every node n. n->len < sz
// (3) every node n. n->len <= n->cap
// (4) every node n. n->data[i] == 0 for all i
int main() {
#if 1
  // Constant values
  SIZE list_sz = N;
  SIZE data_sz = M;
#else
  // Non-deterministic values
  int x = nd_int();
  __CRAB_assume(x > 0);  
  SIZE list_sz = x;
  int y = nd_int();
  __CRAB_assume(y > 0);
  SIZE data_sz = y;
#endif
  
  List node = mk_list(list_sz, data_sz);
  int acc = 0;
  while (node) {
    __CRAB_assert(node->data > 0);              // (1)
    __CRAB_assert(node->len < data_sz);         // (2) 
    __CRAB_assert(node->len <= node->cap);      // (3)
    CRAB_assert_forall(node->data, data_sz, 0); // (4) --> need loop-peeling of mk_list
    node = node->n;
  }
  
  return 0;
}
