def dtob(number):
  # Bitwise converter - Uses the bitshift and Modulo operations.
  # number is input, binary is output.
  binary = []
  if number.isdecimal():
    number = int(number)
    while number:binary.append(number % 2);number >>= 1;
    binary.reverse()
    binary=''.join(map(str, binary))
    return(int(binary))

