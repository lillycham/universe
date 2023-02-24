import sys
from math import *
import typing

def hashStr(string : str) -> int:
	"""
	hashStr(string) -> int:
	- take hash of a string, and return a hashed value as an integer
	"""
	stri  = [ord(char) for char in string]
	rval : str = ""
	# print(ascii_values)
	for value in stri:
		rval = rval + str(value * 5)
	return int(rval) // 2

print(hashStr(str(sys.argv[1])))
