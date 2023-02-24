// Alice and Bob only Greeter
// 05/08/2021

#include<stdio.h>
#include<string.h>

main(){
	char name[15];

	printf("Please enter your name: ");
	scanf("%s", name);

	if((strcmp(name,"Alice") == 0) || (strcmp(name,"Bob") == 0)){
		printf("Hello, %s", name);
	}

	else{
		printf("Access denied!");
	}

	return 0;
}