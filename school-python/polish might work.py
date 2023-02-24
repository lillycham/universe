import operator
from arrayLib import *
operators = {'+': operator.add, '-': operator.sub,
       '*': operator.mul, '/': operator.truediv}


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
        if self.__TOS < self.__size:
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
    def getTos(self):
        return self.__TOS


class RPNApp():
    """
    RPN calculator
    - uses a stack to store the values
    - operators - A lambda with each supported operator in it
    - token list - a list containing the input expression split up so we can parse it
    """
    def __init__(self, expression):
        self.__operators = {
            '+': operator.add, '-': operator.sub, '*': operator.mul, '/': operator.truediv }
        self.__Stack = Stack(8)
        self.__tokenList = expression.split(" ")

    def main(self):
        while True:
            for token in self.__tokenList:
                # first check if the token is a number, then add it to the stack
                if set(token).issubset(set(".0123456789")):
                    self.__Stack.push(token)
                elif token in self.__operators:
                    # then add the op
                    self.__Stack.push(token)
            operator = self.__Stack.pop()
            operand1 = int(self.__Stack.pop())
            operand2 = int(self.__Stack.pop())
            
            self.__Stack.push(self.__operators[operator](operand1, operand2))
        print(self.__Stack.pop())

testvar = input("Enter an expression: ")
testApp = RPNApp(testvar)
testApp.main()