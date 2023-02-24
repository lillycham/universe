#ifndef STACK_H_
#include <stdbool.h>
#define STACK_H_
int peek();
void push(int data);
int pop();
bool isFull();
bool isEmpty();
#endif