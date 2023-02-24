import time
correct="securepleasedonthack"
authed = False
while not(authed):
	pwEntry = input("Enter password:  ")
	if pwEntry == correct:
		authed = True
	else:
		print("incorrect!")
		log = open("log.txt", "a")
		log.write(pwEntry+"\n")
		log.write("time: "+str(time.time())+"\n")
		log.close()