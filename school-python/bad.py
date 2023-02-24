print ("Enter positive integer") 
num = int(input("> ")) 
bits = ""

n = num 

while (n > 0) : 
	b = n % 2 
	n = n // 2
	bits = str(b) + bits

print(str(num)+" in binary is: "+bits)