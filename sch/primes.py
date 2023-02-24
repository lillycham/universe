from itertools import count, tee

def primes():
    '''
    Lazy generator for prime numbers.
    '''
    # 
    coll = {}
    # Start at 2, because primes start at 2.
    num  = 2
    while True:
        if num not in coll:
            # Prime, not in the running total
            yield num
            coll[num * num] = [num]
        else:
            for p in coll[num]:
                coll.setdefault(p+num,[]).append(p)
            # Avoid memory usage issues
            del coll[num]
        num += 1

def isPrime(num: int) -> bool:
    for n in primes():
        if n == num:
            return True
        elif n > num:
            return False

if __name__ == '__main__':
    num = int(input('> '))
    print(isPrime(num))
