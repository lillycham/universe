#include <stdint.h>
#include <stdio.h>

int main(void) {
  uint32_t n = 0;

  while (n < 1000000000)
    n++;
  printf("%i", n);
}