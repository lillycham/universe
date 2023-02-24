def mergeSort(alist) -> list:
	# ensure against infinite recursion
	if len(alist) <= 1:
		return alist

	# split the list in two
	midpoint = len(alist) // 2
	right = alist[midpoint:]
	left = alist[:midpoint]

	mergeSort(left)
	mergeSort(right)
	leftPointer = 0
	rightPointer = 0

	i = 0

	while leftPointer < len(left) and rightPointer < len(right):
		if left[leftPointer] < right[rightPointer]:
			alist[i] = left[leftPointer]
			leftPointer += 1
		else:
			alist[i] = right[rightPointer]
			rightPointer += 1
		i += 1

	# check for leftover elements
	while leftPointer < len(left):
		alist[i] = left[leftPointer]
		leftPointer += 1
		i += 1
  
	while rightPointer < len(right):
		alist[i] = right[rightPointer]
		rightPointer += 1
		i += 1

	return alist

def bubbleSortOptimal(alist) -> list:
		comparisons = len(alist) - 1
		leaveLoop = False           # leaveLoop = can we leave the loop?
		while not leaveLoop:
			leaveLoop = True        # assume it would be sorted this time
			for i in range(0, comparisons):
				if alist[i] > alist[i+1]:
					alist[i], alist[i+1] = alist[i+1], alist[i]
					leaveLoop = False
		return alist

def bubbleSortCheckIfChanged(alist) -> list:
	leaveLoop = False
	while not leaveLoop:
		leaveLoop = True        # assume it would be sorted this time
		for i in range(0, len(alist)-1):
			if alist[i] > alist[i+1]:
				alist[i], alist[i+1] = alist[i+1], alist[i]
				leaveLoop = False
	return alist

def bubbleSortSkipSorted(alist) -> list:
	comparisons = len(alist) - 1
	for index in range(0, len(alist)):
		for i in range(0, comparisons):
			if alist[i] > alist[i+1]:
				alist[i], alist[i+1] = alist[i+1], alist[i]
		comparisons -= 1
	return alist

def bubbleSortUnoptimized(alist):
	n = len(alist)
	for index in range(0, n):
		for i in range(0, n - 1):
			if alist[i] > alist[i+1]:
				alist[i], alist[i+1] = alist[i+1], alist[i]
	return alist