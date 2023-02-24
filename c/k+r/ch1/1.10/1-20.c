#include <stdio.h>
#define TABLENGTH 8	/* the 'length' of a tab is 8 cols */

int main()
{
	int lc = 0, s = 0, c;	/* s = length of a space */
							/* lc = distance from beginning of line */
	while ((c = getchar()) != EOF) {
		if (c == '\t') {
			s = (TABLENGTH - (lc % TABLENGTH));
			while (s > 0) {
				putchar(' ');
				lc++;
				s--;
			}
		}

		else
			putchar(c);
	}
	return 0;
}