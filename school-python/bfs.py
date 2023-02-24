from typing import *; from queuelib import circularQueue; import pyfiglet as fig

class bfs():
	def __init__(self, maze) -> None:
		# Initializes the set to track visited nodes
		self.__visited : Set[Any] = set()
		self.__maze : Dict[int,int] = maze
		self.__queue = circularQueue(len(maze))

	def breadthFirst(self, start, target) -> list:
		"""
		Breadth first traversal
		args:
			- start: the starting node (Any)
			- target: the target node
		"""
		if start == target:
			# If the starting node is equivalent to the goal, return immediately
			return [target]

		self.__visited.add(start)
		self.__queue.enqueue(start)
		# If the starting node is equivalent to the goal, return immediately
		entrance : Dict[Any, Any] = dict(); entrance[start] = None
		found = False

		while self.__queue:
			current = self.__queue.dequeue()
			if current == target:
				found = True
				break

			self.__visited.add(current)
			for neighbour in self.__maze[current]:
				if neighbour not in self.__visited:
					self.__visited.add(neighbour)
					entrance[neighbour] = current
					self.__queue.enqueue(neighbour)

		path = []
		if found:
			path.append(target)
			while entrance[target] != None:
				path.append(entrance[target])
				target = entrance[target]
			path.reverse()
		return path

exits = {
		0: [1],
		1: [0,2,3],
		2: [1],
		3: [1,4,7],
		4: [5,6,9,3],
		5: [6,4],
		6: [11,4,5],
		7: [3,8],
		8: [9,20,7],
		9: [10,8,4],
		10: [11,22,9],
		11: [12,10,6],
		12: [13,11],
		13: [14,16,12],
		14: [15,13],
		15: [17,14],
		16: [18,13],
		17: [15,18],
		18: [17,25,23,16],
		19: [20],
		20: [8,21,19],
		21: [22,20],
		22: [10,23,21],
		23: [18,26,24,22],
		24: [23,26],
		25: [18],
		26: [23,27,24],
		27: [26]}

maze = {
		0: [1,5,4],
		1:[2,0],
		2:[3,1,6],
		3:[2],
		4:[0,8],
		5:[0,6,9,8],
		6:[2,7,9,5],
		7:[6],
		8:[4,5,9],
		9:[8,5,6]}

inst = bfs(exits)
print(fig.figlet_format("Breadth First Search"))
print(inst.breadthFirst(int(input("Enter the starting node: ")), int(input("Enter the goal node: "))))

