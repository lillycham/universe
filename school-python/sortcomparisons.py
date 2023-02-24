import random; import time; import os; import copy;from mergesort import *;from bubblesort import *

class App():
	def main(self):
		os.system("clear")
		userInput = input("Bubble sort: type r for random list, a for almost sorted and s for a sorted list.\n")
		iters = int(input("input the number of iterations to run\n"))

		if userInput == "s":
			alist = [range(1000)]
		elif userInput == "r":
			alist = random.sample(range(1000),1000)
		elif userInput == "a":
			alist = [range(1000)]
			alist[random.randrange(1000)] = random.randrange(1000)

		print("Unoptimized Bubble Sort")
		counter = 0
		for i in range(0,iters):
			copy = alist[:]
			start = time.time()
			bubbleSortUnoptimized(copy)
			end = time.time()
			counter += (end - start)

		print("took: %s seconds over %s runs" % (counter, iters))
		print("average: %s seconds per run \n" %(counter / iters))

		print("Bubble sort: \nOptimisation: Don't check sorted items")
		counter = 0
		for i in range(0,iters):
			copy = alist[:]
			start = time.time()
			bubbleSortSkipSorted(copy)
			end = time.time()
			counter += (end - start)

		print("took: %s seconds over %s runs" % (counter, iters))
		print("average: %s seconds per run \n" %(counter / iters))

		print("Bubble sort: \nOptimisation: Check if the list didn't change")
		counter = 0
		for i in range(0,iters):
			copy = alist[:]
			start = time.time()
			bubbleSortCheckIfChanged(copy)
			end = time.time()
			counter += (end - start)

		print("took: %s seconds over %s runs" % (counter, iters))
		print("average: %s seconds per run \n" %(counter / iters))

		print("Bubble sort: \nOptimal (all optimisations)")
		counter = 0
		for i in range(0,iters):
			copy = alist[:]
			start = time.time()
			bubbleSortOptimal(copy)
			end = time.time()
			counter += (end - start)

		print("took: %s seconds over %s runs" % (counter, iters))
		print("average: %s seconds per run \n" %(counter / iters))

		print("Merge Sort")
		counter = 0
		for i in range(0,iters):
			copy = alist[:]
			start = time.time()
			mergeSort(copy)
			end = time.time()
			counter += (end - start)

		print("took: %s seconds over %s runs" % (counter, iters))
		print("average: %s seconds per run \n" %(counter / iters))

AppInstance = App()
AppInstance.main()
