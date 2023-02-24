#include <stdio.h>
#define MAXLINE 1000 /* Maximum input line size */

int krgetline(char line[], int maxline);
void copy(char to[], char from[]);

/* print longest input line */
int main()
{
	int i;
	int len;

	char line[MAXLINE];

	while ((len = krgetline(line, MAXLINE)) > 0)
		i = len - 2;
		while (i >= 0 && (line[i] == ' ' || line[i] == '\t'))
			--i;

		if (i >= 0) {
			line[i+1] = '\n';
			line[i+2] = '\0';
			printf("%s", line);
		}
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
