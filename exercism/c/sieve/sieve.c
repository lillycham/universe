#include "sieve.h"

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/// Perform the Sieve of Eratosthenes to find all primes up to a limit.
uint32_t sieve(uint32_t limit, uint32_t *primes, size_t max_primes) {
  // Allocate an array of bools to mark off multiples
  bool *markers = (bool *)calloc(limit + 1, sizeof(bool));

  // Count of primes found
  uint32_t pc = 0;

  for (uint32_t i = 2; i <= limit; ++i) {
    // if i is not marked, it is prime
    if (markers[i] == false) {
      // Ensure we haven't done too many primes
      if (pc >= max_primes) {
        return pc;
      }

      // i is a prime
      primes[pc] = i;
      pc++;

      // mark multiples of i as non-primes
      for (uint32_t j = i * i; j <= limit; j += i) {
        markers[j] = true;
      }
    }
  }
  free(markers);
  return pc;
}

// driver program
int main(int argc, char *argv[]) {
  // default limit
  uint32_t limit = 1000000;

  // allocate space for primes
  uint32_t *primes = (uint32_t *)malloc(limit * sizeof(uint32_t));

  // find primes
  uint32_t pc = sieve(limit, primes, limit);

  // print primes
  for (uint32_t i = 0; i < pc; ++i) {
    printf("%d ", primes[i]);
  }

  free(primes);
  return 0;
}
