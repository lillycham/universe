//
//  main.c
//  main
//
//  Created by Lilly Cham on 13/09/2021.
//

#include "main.h"
#include <stdio.h>
/* print Fahrenheit - Celsius scale */

int main() {
  int fahr, celsius;
  int lower, upper, step;
  lower = 0;
  upper = 300;
  step = 20;
  fahr = lower;
  while (fahr <= upper) {
    celsius = 5 * (fahr - 32) / 9;
    printf("%d\t%d\n", fahr, celsius);
    fahr = fahr + step;
  }
}
