from arrayLib import *

class Stack(Array):
    def __init__(self, size):
        self.__size = size
        self.__myArray = Array(size)
        self.__TOS = int(0)

    class StackException(Exception):
        def __init__(self, value): self.value = value
        def toString(self): return self.value

    def push(self, value):
        # Push - Pushes a given value to the stack.
        # Accepts a value of any type.
        # If stack is full, then raises Stack Overflow
        myvalue = value
        if self.__TOS - 1 < self.__size:
            self.__myArray.assign(self.__TOS, myvalue)
            # print(self.__TOS)

            self.__TOS += int(1)
            # print(self.__TOS)
        else:
            raise Exception("Stack Overflow")

    def pop(self):
        # Pop - Removes the top element from the stack.
        # no inputs
        # returns value of the top element.
        if self.__TOS > 0:
            current = self.__myArray.get(self.__TOS - 1)
            self.__myArray.assign(self.__TOS - 1, None)
            self.__TOS -= 1
            return current
        else:
            raise Exception("Stack Empty")

    def printArray(self):
        # printArray - used to Print contents of an array.
        for i in reversed(range(0, self.__size)):
            print(self.__myArray.get(i))