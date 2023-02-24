NumBags = int(input("Input the number of bags: "))
NumSweets = int(input("Input the number of sweets: "))
SweetsPerBag = NumBags / NumSweets
IsEven = SweetsPerBag % 2
if IsEven == 0:
  print("There are an even number of sweets per bag")
else:
  print("there are an odd number of sweets per bag")