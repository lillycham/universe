#include <stdio.h>
#include <stdbool.h>
/* Strip Comments from C source code */

int main()
{
	int c;				/* c = char */
	bool ic = false;	/* ic = in comment, are we currently in a comment block? */
	char lc;			/* lc = last character, what was the last character? */

	while ((c = getchar()) != EOF) {
		if (c == '/' && lc != '*')
			ic = true;

		if ((c == '*') && (lc = '/'))
			ic = true;

		if (!ic)
			putchar(c);

		if ((c == '/') && (lc == '*'))
			ic = false;

		lc = c;
	}
}