from arrayLib import *

class queueFullException(BaseException):
	"""raised when a queue is full"""
	pass

class queueEmptyException(BaseException):
	"""raised when a queue is full"""
	pass


class naiveQueue():
	def __init__(self, l):
		"""
		naive queue
		- takes l : Integer = length of the queue
		- crashes when queue has been filled, because the head and tail have no way to deal with reaching the end of the queue.
		"""
		self.__Array = Array(l)
		self.__head = 0
		self.__tail = 0
		self.__size = l

	def enqueue(self, invalue):
		"""
		Adds invalue to the end of the queue.
		"""
		try:
			self.__Array.assign(self.__tail, invalue)
			self.__tail += 1
		except:
			raise queueFullException()

	def dequeue(self):
		"""
		Dequeues top element from the queue
		"""
		try:
			r = self.__Array.get(self.__head)
			self.__head += 1
			return r
		except:
			raise queueEmptyException()

	def printQueue(self):
		# printQueue - used to Print contents of a Queue.
		for i in range(self.__head, self.__tail):
			print(self.__myArray.get(i))

class asfasdfgcircularQueue():
	"""
	Circular Queue
	- Holds n - 1 items
	- head and tail loop from n to 0
	"""
	def __init__(self, l):
		self.__queue = Array(l)
		self.__max = l - 1
		self.__head = 0
		self.__tail = 0
	   
	def enqueue(self, newitem):
		"""
		Enqueue:
		- Adds newitem to the queue
		- Moves the tail to accomodate for the new item
		- Handles the seamless transfer from end of queue to start with the head and tail pointers
		"""
		if ((self.__tail + 1) % self.__max == self.__head):
			raise queueFullException()

		elif (self.__head == -1):
			self.__head = 0
			self.__tail = 0
			self.queue.assign(self.__tail, newitem)

		else:
			self.__tail = (self.__tail + 1) % self.__max
			self.__queue.assign(self.__tail, newitem)

	def dequeue(self):
		"""
		Dequeue:
		- Dequeues the next item from the queue
		- Moves the head to accomodate for the removed item
		- Handles the transfer from end of queue to start with the head and tail pointers to prevent crashing after queue is filled
		"""
		if (self.__head == -1):
			raise queueEmptyException()

		elif (self.__head == self.__tail):
			r = self.__queue.get(self.__head)
			self.__head = -1
			self.__tail = -1
			return r

		else:
			r = self.__queue.get(self.__head)
			self.__head = (self.__head + 1) % self.__max
			return r

	def peek(self):
		"""
		peek
		- returns the top value of the queue
		"""
		return self.__queue.get(self.__head)

	def printqueue(self):
		"""
		Prints contents of queue for debug purposes
		"""
		for i in range(0, self.__queue.getSize() - 1):
			print(self.__queue.get(i))
 
class priorityQueue():
	"""
	Priority Queue
	- a list of n queues
	- queues have priority based on their position in the list (ie. 0 is the highest priority)
	- queues with a higher priority will be dequeued first
	"""
	def __init__(self, l1, l2):
		self.__list = []
		for i in range(0, l1):
			self.__list.append(circularQueue(l2))
		   
	def enqueue(self, queue, value):
		self.__list[int(queue)].enqueue(value)
	   
	def dequeue(self):
		for i in self.__list():
			if self.__list[i].peek() != None:
				self.__list[i].dequeue()
		
	def printqueue(self):
		for i in self.__list:
			print("\n")
			i.printqueue()

class priorityQueueApp():
	def __init__(self):
		self.__queue = priorityQueue(4, 4)
	def main(self):
		while True:
			queueChoice = input("Enter the queue to enqueue to or nothing to dequeue: ")
			if queueChoice != "":
				inputValue = input("Enter a value to add to the queue: ")
				self.__queue.enqueue(queueChoice, inputValue)
			else:
				self.__queue.dequeue()
			self.__queue.printqueue()
			
class testApp():
	def __init__(self, l):
		length = l
		self.__Queue = naiveQueue(8)
	def main(self):
		while True:
			inputVal = input("Please enter a value to enqueue, or nothing to dequeue: ")
			if inputVal != "":
				try:
					self.__Queue.enqueue(inputVal)
				except queueFullException:
					print("queue is full")
				self.__Queue.printArray()
				
			else:
				try:
					self.__Queue.dequeue()
				except queueEmptyException:
					print("Queue is empty")
				finally:
					self.__Queue.printQueue()
				# try:
				
				# except queueFullException:
				#     print("queue is full")

#myApp = priorityQueueApp()
#myApp.main()

# Circular Queue implementation in Python


class circularQueue():
	def __init__(self, k):
		self.k = k
		self.queue = [None] * k
		self.head = self.tail = -1

	# Insert an element into the circular queue
	def enqueue(self, data):
		if ((self.tail + 1) % self.k == self.head):
			raise queueFullException()

		elif (self.head == -1):
			self.head = 0
			self.tail = 0
			self.queue[self.tail] = data
		else:
			self.tail = (self.tail + 1) % self.k
			self.queue[self.tail] = data

	# Delete an element from the circular queue
	def dequeue(self):
		if self.head == -1:
			raise queueEmptyException()
		
		elif (self.head == self.tail):
			temp = self.queue[self.head]
			self.head = -1
			self.tail = -1
			return temp
		
		else:
			temp = self.queue[self.head]
			self.head = (self.head + 1) % self.k
			return temp

	def printqueue(self):
		if self.head == -1:
			print("No element in the queue")

		elif self.tail >= self.head:
			for i in range(self.head, self.tail + 1):
				print(self.queue[i], end=" ")
			print()
		
		else:
			for i in range(self.head, self.k):
				print(self.queue[i], end=" ")
			for i in range(0, self.tail + 1):
				print(self.queue[i], end=" ")
			print()