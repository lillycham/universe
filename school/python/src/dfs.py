import stackLib; from typing import *; import pyfiglet
 
class dfs():
	def __init__(self, maze):
		self.__maze = maze
		self.__stack = stackLib.Stack(len(maze))
		self.__visited = [False] * len(maze)
 
	def depthFirst(self) -> None:
		"""
		Depth first traversal
		args:
			- graph: an adjacency list (Dictionary) of a graph
			- node: the starting node (Any)
		returns: Set[Any]
		"""
		start = 8
		finished = False
		current = start
		while not finished:
			try:
				print(pyfiglet.figlet_format(current))
				if not (self.__nodeComplete(current)):
					self.__stack.push(current)
 
				self.__visited[current] = True
				next = self.__findNextNode(current)
 
				if next != None:
					current = next
				else:
					current = self.__stack.pop()
					print("Deadend: returning to", current, end='\n')
				self.__stack.printArray()
				input()
			except:
				print("Done")

	def __findNextNode(self, node) -> node:
		#finds next unvisited node in the adjacency list
		nodes = self.__maze[node]
		i = 0
		while i<len(nodes):
			if not(self.__visited[ nodes[i] ]):
				return self.__maze[node][ i ]
			else:
				i += 1
		return None

	def __nodeComplete(self, node) -> Bool:
	#returns true if node p has been fully explored
		nodes = self.__maze[node]
		i = 0
		while i<len(nodes):
			if not(self.__visited[ nodes[i] ]):
				return False
			else:
				i += 1
		return True

maze = {0: [1,5,4], 1:[2,0], 2:[3,1,6], 3:[2], 4:[0,8], 5:[0,6,9,8], 6:[2,7,9,5], 7:[6], 8:[4,5,9], 9:[8,5,6]}
inst = dfs(maze)
print(pyfiglet.figlet_format("Depth \n First \n Search"))
print("Visited nodes: %s"% inst.depthFirst())