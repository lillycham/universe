#include <stdio.h>
#define MAXLINE 1000 /* Maximum input line size */

int krgetline(char line[], int maxline);
void copy(char to[], char from[]);

/* print longest input line */
int main()
{
	int len;				/* current line length */
	int max;				/* maximum line length so far */

	char line[MAXLINE];
	char longest[MAXLINE];

	max = 0;

	while ((len = krgetline(line, MAXLINE)) > 0)
		if (len > max) {
			max = len;
			copy(longest, line);
		}
	if (max > 80)
		printf("%s", longest);
	return 0;
}

/* getline: read a line into s, then return length */
int krgetline(char s[], int lim)
{
	int c, i;
	for (i = 0; i<lim-1 && (c=getchar()) !=EOF && c!='\n';++i)
		s[i] = c;
	if (c == '\n') {
		s[i] = c;
		++i;
	}
	s[i] = '\0';
	return i;
}

/* copy: copy 'from' into 'to', assuming to is big enough. */
void copy(char to[], char from[])
{
	int i;

	i = 0;
	while ((to[i] = from[i]) != '\0')
		++i;
}