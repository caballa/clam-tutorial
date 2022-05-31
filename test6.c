#include <stdio.h>
#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>
#include <stdbool.h>

// RUN: %clam --crab-inter --crab-track=mem --crab-dom=zones --crab-check=assert --crab-heap-analysis=cs-sea-dsa-types --crab-lower-unsigned-icmp=true --crab-dom-params="region.is_dereferenceable=true" "%s" 2>&1 | OutputCheck %s
// CHECK: ^1  Number of total safe checks$
// CHECK: ^0  Number of total warning checks$

#include "clam/clam.h"

/**
 * Example that shows how to prove absence of buffer overflows.
 * The special function
 *     bool sea_is_dereferenceable(const void *ptr, intptr_t offset)
 * returns true if offset number of bytes of ptr are allocated.
 **/
struct aws_byte_buf {
    size_t len;
    uint8_t *buffer;
    size_t capacity;
    struct aws_allocator *allocator;
};


struct aws_byte_buf * gbuf;

size_t size_t_nd(void) {
    int res = nd_int();
    __CRAB_assume(res >= 0);
    return res;
}

void initialize_byte_buf(struct aws_byte_buf *const buf, size_t cap) {
    size_t len = size_t_nd();
    __CRAB_assume(len <= cap);
    buf->len = len;
    buf->capacity = cap;
    buf->buffer = malloc(cap * sizeof(*(buf->buffer)));
}

int main(void) {
  struct aws_byte_buf * buf = (struct aws_byte_buf*) malloc(sizeof(struct aws_byte_buf));
  gbuf = buf;
  
  if (nd_int()) {
    size_t cap = size_t_nd();
    __CRAB_assume(cap <= 512);
    initialize_byte_buf(gbuf, cap);
  } else {
    size_t cap = size_t_nd();
    __CRAB_assume(cap <= 1024);
    initialize_byte_buf(gbuf, cap);
  }

  __CRAB_assert(sea_is_dereferenceable(gbuf->buffer, gbuf->len));
  return 0;
}
