import time;from typing import *;from os import system, name;from pyfiglet import figlet_format;import sys

"""
	 📝 Notebook app ✨
	 - Simple note taking 📝 app with dictionaries 
	 TODO:
	 - Implement saving to disk using Pickle 💾
"""


class page():
	"""
	This is the page dataclass that is used to hold the data of each page.
	"""
	def __init__(self, content, created, tags) -> None:
		self.__content = content
		self.__created = created
		self.__tags    = tags

	def setContent(self, newContent :str) -> None:
		"""Edit the content of the page"""
		self.__content = newContent
	
	def printContent(self) -> None:
		print(self.__content)

class cmds:
	""" This class provides all the commands that are available during editing. """
	def help(self) -> None:
		print("Welcome to TwoNote!\n- To view a list of available commands, type ls command\n- To exit, type qa")

	def ls(self, arg : str) -> None:
		if arg == "cmds" or arg == "commands":
			print("Commands:\nh or help: print help\nn or new: new page\nw or write or save or wo: write out pages to disk\nqa: quit all (WARNING: DOES NOT FLUSH DATA! MAKE SURE TO SAVE BEFORE!)\nf or find or search: search for pages based on tags and titles\nls command: list available commands\nls page: list pages")

		elif arg == "notes" or arg == "pages":
			for each in run.notebook:
				print("note name: "+each)
				print("note content: ", end="")
				run.notebook.get(each).printContent()

		else: print("ls: unrecognized argument %s" % arg)

	def write(self) -> None:
		pass

	def find(self) -> None:
		pass

	def clear(self) -> None:
		"""
		clear clears the screen, but i can't just call system("clear") because windows is annoying and doesn't do clear, it does cls for whatever reason so this is just a check whether on a posix (good) os or a windows os
		"""
		if name == 'nt':
			_ = system('cls')
		# for good operating systems, it calls clear 
		else:
			_ = system('clear')

	def runfunc(self, function : str) -> None:
		"""runs given function (for debugging purposes)"""
		try: exec(function)
		except Exception as e: print("execution failed with error %s" % e)

	# Aliases - these are just to provide multiple names for one command without writing it out several times
	h    =  help
	w    =  write
	wo   =  write
	save =  write
	f    =  find

class App(object):
	def __init__(self) -> None:
		self.notebook : Dict[str, Any] = {}
		self.tags = {}

	def addpage(self, name : str, c : str = "", t : List[str] = []) -> None:
		"""
		addpage()
		- adds a new page named t with optional content c and optional tags t to the notebook
		- returns None (void)
		"""
		self.notebook[name] = page(content = c, created = time.time(), tags = t)

	def editpage(self, t : str, c : str) -> None:
		"""
		editpage()
		- edits page named t to content c
		- returns None (void)
		"""
		self.notebook[t].setContent(c)


	# def addtag(self, t, n) -> None:
	# 	"""
	# 	addtag() 
	# 	- add tag t to notebook n
	# 	- returns None
	# 	"""
	# 	self.tags[n] = t

	def main(self) -> None:
		banner = figlet_format("TwoNote")
		print(banner)
		print("Welcome to TwoNote! \nType help or h to see more information, or type qa to quit.\n")
		lCmds = cmds()
		Alive = True

		while Alive:
			command : str = input("->")
			if command == "qa":
				confirm = input("really wanna quit? any unsaved changes will be lost! (y / n):  ")
				if confirm in "Yy":
					print("goodbye!")
					Alive = False
				else:pass;

			elif command == "new":
				self.NewNoteView()

			elif command == "editpage":
				try: self.editpage(input("what page to edit ->  "), input("What to set the content of the page to ->  "))

				except Exception as e: print("failed to edit page: %s" % e)

			else:
				if " " in command:
					strarg  : str = str(command.split(" ")[1])
					command = str(command.split(" ")[0])
					try: method = getattr(lCmds, command)
					except: print("Unrecognized command %s. Enter h or help for information." % command)
					else:
						try: method(str(strarg));
						except Exception as e: print("Trailing argument %s in command %s. exception raised: %s" %(strarg, command, e))

				else:
					try: method = getattr(lCmds, command)
					except: print("Unrecognized command %s. Enter h or help for information." % command)
					else:
						try: method();
						except: print("Command %s requires an argument." % command)

	def NewNoteView(self) -> None:
		__Alive : bool = True
		while __Alive:
			name    = input("Enter the name of the note ->  ")
			content = input("Enter the content of the note ->  ")
			tags    = input("Enter some tags (seperated by commas)->  ").split(",")
			self.addpage(name, content, tags)
			__Alive = False

run = App()
run.main()
