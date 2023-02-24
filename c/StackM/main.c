#include "stack.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char *mnem[] = {"push", "pop", "add", "ifeq", "jump", "print", "dup"};

int main(int argc, char **argv) {
  char *str = "push\t10\t";
  char *dup = strdup(str);

  int i = 0;
  char *split[32];
  char *tok = strtok(dup, "\t");

  while (tok != NULL) {
    split[i++] = tok;
    tok = strtok(NULL, "\t");
  }

  char *temp;

  int operand = (int)strtol(split[i + 1], &temp, 0);
  if (strcmp(split[i], "push") == 0) {
    push(operand);
  }
  printf("%d\n", peek());
}
