from itertools import groupby

print(''.join(['{} {} '.format(k, sum(1 for _ in v))
               for k,v in groupby(input('enter str> '))]))

