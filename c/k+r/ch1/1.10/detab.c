#include <stdio.h>
#define TAB 8	/* length of a tab */

int main()
{
	int count = 0, space = 0, c;

	while ((c = getchar()) != EOF) {
		if (c == '\t') {
			space = (TAB - (count % TAB));
			while (space > 0) {
				putchar(' ');
				count++;
				space--;
			}
		}

		else
			putchar(c);
	}
	return 0;
}