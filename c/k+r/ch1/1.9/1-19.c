#include <stdio.h>
#define MAXLINE 1000

void reverseLine(char reversedLine, char line[], int lineSize);

int main()
{
	int i;
	int c;

	char line[MAXLINE];

	while ((c = getchar())!= EOF && c != '\n')
		line[i++] = c;

	if (c == '\n')
		line[i++] = '\0';

	int size = i;
	char reversedLine[size];

	reverseLine(reversedLine, line, size);
	printf("%s\n", reversedLine);

	return 0;
}

void reverseLine(char reversedLine, char line, int lineSize)
{
	int j, k;
	for (j = lineSize - 2, k = 0; j >= 0; j--, k++) {
		reversedLine[k] = line[j];
	}
	reversedLine[k] = '\0';
}

