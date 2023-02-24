#include <stdio.h>
#include <math.h>
#include <stdlib.h>

long decimalBinary(long n) {
	if (n >= 1)
		decimalBinary(floor(n / 2));
	printf("%ld", (n % 2));
	return 0;
}


int main(int argc, char **argv)
{
	long n;
	char *temp;
	if (argc > 2) {
    	printf("Too many arguments\n");
    	return 1;
	}

	n = strtol(argv[1], &temp, 10);
	if (*temp != '\0') {
		printf("Invalid input\n"); return 1;
	}
	decimalBinary(n);
	printf("\n");
	return 0;
}
