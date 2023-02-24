from arrayLib import *
 
class circularQueue():
    def __init__(self, l):
        self.__queue = Array(l)
        self.__max = l - 1
        self.__head = 0
        self.__tail = 0
       
    def enqueue(self, newitem):
        if ((self.__tail + 1) % self.__max == self.__head):
            print("The circular queue is full")

        elif (self.__head == -1):
            self.__head = 0
            self.__tail = 0
            self.queue.assign(self.__tail, newitem)
        else:
            self.__tail = (self.__tail + 1) % self.__max
            self.__queue.assign(self.__tail, newitem)

    def dequeue(self):
        if (self.__head == -1):
            print("circular queue is empty")

        elif (self.__head == self.__tail):
            v = self.__queue.get(self.__head)       # gets the head of the queue and assigns it to v
            self.__head = -1                        # decreases head by 1
            self.__tail = -1                        # decreases tail by 1
            return v                                # returns v which is the head of the queue
        else:
            v = self.__queue.get(self.__head)
            self.__head = (self.__head + 1) % self.__max
            return v

    def printqueue(self):
        for i in range(0, self.__queue.getSize() - 1):
            print(self.__queue.get(i))
 
class circApp():
    def main():
        queue = circularQueue(8)
        while True:
            inputStr = input("Please enter a thing to add to the queue, or nothing to dequeue: ")
            if inputStr != "":
                queue.enqueue(inputStr)
                queue.printqueue()
            else:
                queue.dequeue()
                queue.printqueue()
               
 
circApp.main()