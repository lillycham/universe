#include <stdio.h>
/* print Fahrenheit to Celsius table
   floating-point version - refactored with function */

float conv(float f)
{
	float c;
	c = ((5.0/9.0) * f - 32.0);
	return c;
}

int main()
{
	float fahr, celsius;
	int lower, upper, step;

	lower = 0;
	upper = 300;
	step = 20;

	fahr = lower;
	printf("Cel | Fahr\n");
	while (fahr <= upper) {
		celsius = conv(fahr);
		printf("%3.0f %6.1f\n", fahr, celsius);
		fahr = fahr + step;
	}
}