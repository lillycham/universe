from math import pi

def findCircleArea(diameter):
  radius = diameter / 2
  return pi * radius ** 2

def findCostSqrInch(area, price):
  costPerSqrInch = area / price 
  return costPerSqrInch

# print(findCircleArea(float(input("input the diameter: "))))

pizzas = [["Margherita",10,6.20],["Margherita",12,7.70],["Margherita",14,9.40],["Margherita",16,12.40],["Vegetarian",10,8.10],["Vegetarian",12,9.80],["Vegetarian",14,11.80],["Vegetarian",16,15.60]]

for i in range(0,len(pizzas)):
  print(pizzas[i][0])
  area = findCircleArea(pizzas[i][1])
  costPerSqrInch = pizzas[i][2] / area