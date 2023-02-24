#include <stdio.h>

/* copy input to output; v2 */

main()
{
	int c;

	c = getchar();
	while ((c = getchar()) != EOF)
		putchar(c);
}
