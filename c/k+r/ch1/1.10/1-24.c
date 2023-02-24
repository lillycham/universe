#include <stdio.h>

int main()
{
	int p = 0, br = 0, b = 0, c;	/* p = parentheses, br = braces, b = brackets */

	while ((c = getchar()) !=EOF) {
		if (c == '(')
			p++;

		else if (c == ')')
			p--;

		else if (c == '[')
			b++;

		else if (c == ']')
			b--;

		else if (c == '{')
			br++;

		else if (c == '}')
			br--;
	}

	if (p > 0)
		printf("\nError: unclosed (parentheses)\n");

	if (b > 0)
		printf("\nError: unclosed [brackets]\n");

	if (br > 0)
		printf("\nError: unclosed {braces}\n");

	if (p < 0)
		printf("\nError: extraneous closing (parentheses)\n");

	if (b < 0)
		printf("\nError: extraneous closing [brackets]\n");

	if (br < 0)
		printf("\nError: extraneous closing {braces}\n");

	else
		printf("\nNo errors found\n");
	return 0;
}