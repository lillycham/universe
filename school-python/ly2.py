def findLeapYear(year):
    if year % 4 == 0 and (year % 100 != 0 or year % 400 == 0):return True;
    else:return False;

def findLeapYearRange(year1,year2):
    for y in range(int(year1),int(year2)):
        if findLeapYear(y):print(y);

#LeapYear = input("Input the year you want to check: ")

#print(findLeapYear(LeapYear))

LeapYear1 = input("Input the year you want to check: ")

LeapYear2 = input("Input the second year you want to check: ")

findLeapYearRange(LeapYear1,LeapYear2)