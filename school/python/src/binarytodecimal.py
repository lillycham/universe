def bin_to_dec(binary):
    decimal = 0
    for i in range(binary): 
        digit = binary % 10 
        decimal = decimal + digit * pow(2 , i)
        binary = binary//10 
    return decimal

print(bin_to_dec(int(input("Enter a binary number: "))))


