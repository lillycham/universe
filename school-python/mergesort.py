import random; import time; import os; import copy

def mergeSort(alist):
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