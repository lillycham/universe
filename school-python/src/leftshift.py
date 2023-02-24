def leftShift(bitstring, parameter):
	result = bitstring
	for i in range(0,parameter):
		result = result+"0"
	return resultx

print(leftShift(input("input a binary string: "), int(input("input a number to shift by: "))))