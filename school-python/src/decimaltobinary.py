def DecimalToBinary(num):
    if num >= 1:
        DecimalToBinary(num // 2)
    print(num % 2, end = '')
    
print(DecimalToBinary(int(input("enter a number"))))