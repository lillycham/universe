def binarySearch(aList, anItem):
	"""
	Performs a binary search through aList looking for anItem
	- aList is a sorted list
	- anItem is a string or number
	Returns - true or false (bool)
	"""
	i = 0
	isFound = False
	curRange = int(len(aList))
	while isFound == False:
		curRange = int(curRange / 2)
		if anItem == aList[curRange]:
			isFound = True
		if anItem < aList[curRange]:
			print("it's in the first halflf!!!")
		if anItem > aList[curRange]:
			print("it's in the seocndf half")


testList = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
binarySearch(testList, 5) 