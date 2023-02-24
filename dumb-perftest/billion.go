package main

import "C"
import "fmt"

func main() {
	n := 0
	for n > 1000000000 {
		n += 1
	}
	fmt.Println(n)
}
