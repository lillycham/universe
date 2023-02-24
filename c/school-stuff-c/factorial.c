#include <stdio.h>
#include <stdlib.h>

long findFactorial(long n)
{
	if (n >=1) {
		return n * findFactorial(n - 1);
	}

	else {
		return 1;
	}
}

main(int argc, char **argv)
{
	char *temp;
	long n = strtol(argv[1], &temp, 10);
	if (*temp != '\0') {
		printf("panic: invalid argument\n"); return 1;
	}
	printf("%ld\n", findFactorial(n));
}