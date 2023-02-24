#include <stdio.h>
#include <stdlib.h>

long findFibonacci(long n)
{
	if (n <= 1) {
		return n;
	}

	else {
		return findFibonacci(n - 1) + (findFibonacci(n - 2));
	}
}

main(int argc, char **argv)
{
	char *temp;
	long n = strtol(argv[1], &temp, 10);
	if (*temp != '\0') {
		printf("panic: invalid argument\n"); return 1;
	}
	printf("%ld\n", findFibonacci(n));
}