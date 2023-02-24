def pangramChecker(input):
    input = input.lower()
    input = set(input)
    alpha = [ ch for ch in input if ord(ch) in range(ord('a'), ord('z')+1)]
    if len(alpha) == 26:
        return 'true'
    else:
        return 'false'

print(pangramChecker(input("Enter a string to check for a pangram: ")))