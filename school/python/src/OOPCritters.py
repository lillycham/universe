# Python OOP Critters

from random import randrange

class Critter(object):
	def __init__(self, name, hp, s, c):	# Initialise the instance
		self.__name = name
		self.__health = hp
		self.__strength = s
		self.__damage = 0
		self.alive = True
		self.__chanceToHit = c
		#print("test")
  
	def talk(self):	# Print information about the critter; no params other than self
		print("Hello, I am "+self.__name)
		print("I have "+str(self.__health)+" health and "+str(self.__strength)+" strength")	
  
	def hit(self,other):	# Attack the other critter with str/2 * dice roll of 1-6, needs a critter to attack as param	
		self.__damage = randrange(6) * self.__strength / 2
		other.__health = other.__health - self.__damage 
		print(self.__name+" hit "+other.__name+" for "+str(self.__damage)+" damage!" );print(other.__name+" has "+str(other.__health)+" health")
		if self.__health <= 0:
			self.alive = False
class Spider(Critter):
  def __init__(self, name, hp, s, c):
    super().__init__(self, name, hp, s, c)
  def hit(self, other):
    for i in range(1,8):
    	super().hit(other)

class Skeleton(Critter):
  def __init__(self, name, hp, s, c):
    super().__init__(self, name, hp, s, c)
  def hit(self, other):
    for i in range(1,randrange(1-3)):
    	super().hit(other)

class Wolf(Critter):
  def __init__(self, name, hp, s, c):
    super().__init__(self, name, hp, s, c)
  def hit(self, other):
    for i in range(1,randrange(1-3)):
    	super().hit(other)
			
class Robot(Critter):
  def __init__(self, name, hp, s, c):
    super().__init__(self, name, hp, s, c)
  def hit(self, other):
    for i in range(1,randrange(1-3)):
    	super().hit(other)

class critterFarm(object):
	def __init__(self):
		self.__critters = 0
	def createCritter(self, name):
		return Critter (name, randrange(1,10), randrange(1,10), randrange(1,10))
	def createSpider(self, name):
		__hp = randrange(1-5)
		__s = randrange(1-5)
		__c = randrange(1-5)
	def createSkeleton(self, name):
		__hp = randrange(1-5)
		__s = randrange(1-5)
		__c = randrange(1-5)
	def createWolf(self, name):
		__hp = randrange(1-5)
		__s = randrange(1-5)
		__c = randrange(1-5)
	def createRobot(self, name):
		__hp = randrange(1-5)
		__s = randrange(1-5)
		__c = randrange(1-5)
  #critterFarm.createCritter("a")

class App:
	def __init__(self):
		self.__critters = []
	def main():
		bob = critterFarm.createCritter(critterFarm, "Bob")
		steve = critterFarm.createCritter(critterFarm, "steve")
		bob.talk()
		steve.talk()
		while bob.alive == True and steve.alive == True:
			bob.hit(steve)
			steve.hit(bob)
		print("Game Over!")
App.main()