#include <stdio.h>
#define COL 80
/* Fold lines after 80 columns */

int main()
{
	int c, count;

	while ((c = getchar()) != EOF) {
		count++;
		if ((c == ' ' || c == '\t') && count >= COL)	/* There are probably more whitespace characters. */
			putchar('\n');
		else
			putchar(c);
	}
	return 0;
}