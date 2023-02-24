#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>

long binaryDecimal(long b) {
	long d = 0, r = 0, count = 0;
	while (b) {
		d = b % 10;
		r = r + d * pow(2, count);
		b = floor(b/10);
		count++;
	}
	return r;
}

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

	if (argc < 2) {
		printf("panic: too few arguments, see -h for help\n");
		exit(1);
	}

	if (argc > 3) {
    	printf("panic: too many arguments, see -h for help\n");
    	exit(1);
	}

	if (strcmp(argv[1], "-h") == 0) {
		printf("binary-decimal converter\n-b\tconvert decimal to binary\n-d\tconvert binary to decimal\n");
		exit(0);
	}

	n = strtol(argv[2], &temp, 10);
	if (*temp != '\0') {
		printf("panic: invalid argument, see -h for help\n"); return 1;
	}

	else if (strcmp(argv[1], "-b") == 0) {
		printf("%ld\n", binaryDecimal(n));
	}

	else if (strcmp(argv[1], "-d") == 0) {
		decimalBinary(n);
		putchar('\n');
	}

	else {
		printf("panic: invalid argument, see -h for help\n");
		exit(1);
	}

	return 0;
}