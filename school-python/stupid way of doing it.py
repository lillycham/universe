for i in range(0,3000):
	year = i
	print(year,end = "\t")
	if year % 4 == 0 and (year % 100 != 0 or year % 400 == 0):
		print("It is a leap year")
	else:
		print("it is not a leap year")