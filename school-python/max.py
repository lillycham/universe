alist = ["cat","dog","aaaaaa","verylongword"]
#print(max(alist))

def longestWord(alist):
	max_len = -1
	for i in alist:
	    if len(i) > max_len:
	        max_len = len(i)
	        return i

print(longestWord(alist))