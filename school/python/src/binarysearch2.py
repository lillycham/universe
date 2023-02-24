import sys
from typing import *

def binarySearch(alist : list[int], value : int) -> bool:
	"""
	Performs a binary search through aList[int] looking for anItem[int]
	Returns - True or False (bool)
	"""
	low = 0
	high = len(alist)-1

	while low <= high: 
		mid = (low + high) // 2

		if alist[mid] > value: 
			high = mid - 1

		elif alist[mid] < value: 
			low = mid + 1

		else: 
			return True

	return False

testList = list(range(1, 50))

print(binarySearch(testList, int(sys.argv[1])))

