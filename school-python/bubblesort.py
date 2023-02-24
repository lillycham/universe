def bubbleSortOptimal(alist):
        comparisons = len(alist) - 1
        leaveLoop = False           # leaveLoop = can we leave the loop?
        while not leaveLoop:
            leaveLoop = True        # assume it would be sorted this time
            for i in range(0, comparisons):
                if alist[i] > alist[i+1]:
                    alist[i], alist[i+1] = alist[i+1], alist[i]
                    leaveLoop = False
        return alist

def bubbleSortCheckIfChanged(alist):
    leaveLoop = False
    while not leaveLoop:
        leaveLoop = True        # assume it would be sorted this time
        for i in range(0, len(alist)-1):
            if alist[i] > alist[i+1]:
                alist[i], alist[i+1] = alist[i+1], alist[i]
                leaveLoop = False
    return alist

def bubbleSortSkipSorted(alist):
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