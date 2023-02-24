#include <stdbool.h>
#include <stdio.h>
#define SIZE 16

int stack[SIZE];
int top = -1;

bool isFull()
{
	if (top == SIZE) {
		return true;
	}

	else {
		return false;
	}

}

bool isEmpty()
{
	if (top == -1) {
		return true;
	}

	else {
		return false;
	}

}

int peek()
{
	return stack[top];
}

void push(int data)
{
	if(!isFull()) {
		top = top + 1;
		stack[top] = data;
	}
	else {
		printf("STACK FULL\n");
	}
}

int pop()
{
	int data;

	if(!isEmpty()) {
		data = stack[top];
		top = top - 1;
		return data;
	}
	else {
		printf("STACK EMPTY\n");
	}
}

