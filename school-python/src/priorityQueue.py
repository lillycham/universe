from circularqueue import *
 
class priorityQueue():
    def __init__(self, l1, l2):
        self.__list = []
        for i in range(0, l1):
            self.__list.append(circularQueue(l2))
           
    def enqueue(self, q, n):
        self.__list[q].enqueue(n)
       
    def dequeue(self):
        for i in self.__list():
           
            self.__list[q].dequeue()
       
        
    def prin(self):
        for i in self.__list:
            print("\n")
            i.printqueue()
           
 
myq = priorityQueue(4, 4)
 
myq.enqueue(1, "Cat")
myq.prin()