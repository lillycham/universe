def tasktime():
  slow = 0
  medium = 0
  fast = 0
  timetaken = 1
  while timetaken > 0:
    timetaken = int(input("input time: "))
    if timetaken==0:return(fast, medium, slow)
    elif timetaken < 30: fast =+ 1; print(fast)
    elif timetaken < 60: medium =+ 1; print(medium)
    slow =+1
print(tasktime())