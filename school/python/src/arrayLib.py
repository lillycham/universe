from typing import *
""" 
Array Class
T Street
version 1.1.1	2022
"""


class Array(object):
	"""A simulated Array in Python because Python does not have arrays"""
	def __init__(self, size : int) -> None:
		self.__size = size
		self.__array : list [Any] = []
		for i in range(size):
			self.__array.append(None)

	def getSize(self) -> int:
		"""Returns the size of the array"""
		return self.__size

	def get(self, n : int) -> Any:
		"""Returns the value in index n"""
		if n>= self.__size or n<0:
			raise ArrayException("Index "+str(n)+" out of bounds.")
		return self.__array[n]

	# added by me :)
	def __getitem__(self, n: int) -> Any:
		return self.get(n)

	def __setitem__(self, n:int, value: Any) -> None:
		return self.assign(n, value)

	def assign(self, n : int, value: Any) -> None:
		"""Sets element n to value"""
		if n>= self.__size or n<0:
			raise ArrayException("Index "+str(n)+" out of bounds.")
		self.__array[n] = value


class ArrayException(Exception):
	def __init__(self, value : str) -> None:
		self.value = value

	def toString(self) -> Any:
		return self.value 



	

