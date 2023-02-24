def stringChecker(str1, str2):
	if all(s in str1 for s in str2):return True;
	return False
wordfor = input("input a word to check for: ")
wordagainst = input("input a word to check against: ")
print(stringChecker(wordagainst,wordfor))