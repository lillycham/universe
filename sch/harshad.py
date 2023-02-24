from itertools import count, islice         # `count` creates a generator object of integers beginning at n. `islice` slices an iterator.
from typing    import Generator             # Type hint for `Generator` objects. No effect on functionality.

def split_nums(num: int) -> list[int]:
    return [int(n) for n in str(num)]

def is_harshad(num: int) -> bool:
    summed = sum(split_num(num))
    return   (num % summed) == 0

def harshads() -> Generator[int, None, None]:
	return (n for n in count(1) if isHarshad(n))

if __name__ == '__main__':
    while True:
        try:
            val = input('Enter a number: ')
            num = int(val) if int(val) > 0 else (lambda: (_ for _ in ()).throw(ValueError))()
        except ValueError:
            print('Input must be a number greater than zero.')
            continue
        print(f'the {num} harshad number is {list(islice(harshads(), num))[-1]}')
