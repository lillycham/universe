def UKVampire():
  ukpopulation = 65600000
  day = 0
  numberofvampires = 1
  while ukpopulation > 0: 
    ukpopulation = ukpopulation - numberofvampires
    numberofvampires *= 2 
    day += 1
    print(day)
  print(day)

UKVampire()

def WorldVampire():
  worldpopulation = 7400000000
  day = 0
  numberofvampires = 1
  while worldpopulation > 0: 
    worldpopulation = worldpopulation - numberofvampires
    numberofvampires *= 2 
    day += 1
    print(day)
  print(day)

WorldVampire()
