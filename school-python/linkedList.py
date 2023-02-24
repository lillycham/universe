class listItem():
    """
    List Item
    - holds a pointer to the listItem that is connected to, and the content held within the item
    - allows changing content and link with setLink and setContent
    - this would probably be better with a struct, but python doesn't have those for some reason.
    """

    def __init__(self, content, link=None):
        self.__link = link
        self.__content = content
   
    def setLink(self, link):
        self.__link = link
 
class linkedList():
    def __init__(self):
        self.__memory = [listItem()]
 
    def pop(self):
        self.__memory[(len(self.__memory) - 1)].setLink(len(None))
 
    def add(self, value):
        self.__memory[(len(self.__memory) - 1)].setLink(len(self.__memory))
        self.__memory.append(listItem(value))
 
    def shift(self):
        pass
 
    def unshift(self):
        pass
 
    def remove(self, index):
        pass
 
    def insert(self, index):
        pass

    def peek(self, index):
        pass

    def getLength(self):
        pass