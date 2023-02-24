#include <stdio.h>

int main() {
  long sum;
  sum = 0;
  for (int i = 0; i <= 1000000000; i++) {
    sum += i;
  }

  printf("The sum from 0 to 1000000000 is %ld \n", sum);

  return 0;
}
