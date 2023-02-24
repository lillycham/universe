#include <stdio.h>

#define IN 1
#define OUT 0

/* split input words into lines */
main()
{
	int c;
	while ((c = getchar()) != EOF) {
		if (c == ' ' || c == '\n' || c == '\t')
			putchar('\n');
		else
			putchar(c);
	}
}