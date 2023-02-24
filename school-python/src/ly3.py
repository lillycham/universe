def findLeapYear(year : int) -> bool:
  if year % 4 == 0:
    return True
  else:
    return False

def findLeapYearRange(year1 : int, year2 : int) -> None:
  for y in range(year1, year2):
    if findLeapYear(y):
      print(y);





LeapYear : int = int(input("Input the year you want to check: "))
print(findLeapYear(LeapYear))


LeapYear1 = int(input("Input the year you want to check: "))

LeapYear2 = int(input("Input the second year you want to check: "))

findLeapYearRange(LeapYear1, LeapYear2)
