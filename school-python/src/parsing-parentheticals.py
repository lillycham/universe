from itertools import groupby; import timeit

def parse(string):
    parsed_string = []
    for char in string:
        if char == "(":
            substr, right_bracket = parse(string)
            if not right_bracket:
                raise Exception("Invalid expression - String contains unbalanced number of parenthesis!")
            parsed_string.append(substr)
        elif char == ")":
            return parsed_string, True
        else:
            parsed_string.append(char)
    return parsed_string, False

def combine(d1):
  return [i for a, b in groupby(d1, key=str.__instancecheck__) 
          for i in ([''.join(b)] if a else map(combine, b))]

def ugly_print(x):
    print(combine(x))
    for elem in x:
        if type(elem) is list:
            ugly_print(elem)

def main(string):
    result = parse(iter(string))[0]
    ugly_print(result)            

if __name__ == '__main__':
    print("Time taken to perform 10000 iterations: ", timeit.timeit(lambda: main("This is a (test (to (see))) (if it (works))"), number=10000))