def BinaryToDecimal(binary):
    decimal = 0 
    count = 0 
    while binary: 
        digit = binary % 10 
        decimal = decimal + digit * pow(2 , count)
        binary = binary//10 
        count += 1              
    return decimal
binary = int(input("Enter a binary number: "))
print(BinaryToDecimal(binary))

