package sieve

func Sieve(limit int) []int {
	// alloc slices
	markers := make([]bool, limit+1)
	primes := make([]int, limit/2)

	// counter
	pidx := 0

	for i := 2; i <= limit; i++ {
		if !markers[i] {
			// Found a prime
			primes[pidx] = i
			pidx++
			// mark muls
			for n := i + i; n <= limit; n += i {
				markers[n] = true
			}
		}
	}

	return primes[:pidx]
}
