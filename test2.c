// RUN: %sea pf --max-depth=20 --crab "%s" 2>&1 | OutputCheck %s
// CHECK: ^unsat$

// Without --crab seahorn should not terminate.

#include "clam/clam.h"

/**
 * Example that shows the use of Clam in SeaHorn
 **/

#define sassert(X)							\
  if (!(X)) {								\
    __VERIFIER_error();							\
  }

int main() {
  int x, y;
  x = 1;
  y = 0;
  while (nd_int()) {
    x = x + y;
    y++;
  }
  sassert(x >= y);
  return 0;
}
