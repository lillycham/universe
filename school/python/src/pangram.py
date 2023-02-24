#!/usr/bin/env python3
import sys
def pangramChecker(astr: str) -> bool:
  astr = set(astr.lower())
  alpha = { ch for ch in astr if ord(ch) in range(ord('a'), ord('z')+1) }
  return True if len(alpha) == 26 else False

if __name__ == '__main__':
	if len(sys.argv) >= 2:
		print(pangramChecker(' '.join(sys.argv[1:])))
	else:
		print(f"Usage: {sys.argv[0]} <string>")