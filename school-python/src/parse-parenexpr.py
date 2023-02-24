import tree.py
def main(string: str):
	root: Node
	split_string: str	
	for i in range(0, len(string)):
		if string[i] == "(":
			root = Node(string [0:i])
			split_string = string[0:i]
			break

	for i in range(0, len(split_string)):
			if root.left is not None:

if __name__ == "__main__":
	main("beebo")