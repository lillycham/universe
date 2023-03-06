package letter

// FreqMap records the frequency of each rune in a given text.
type FreqMap map[rune]int

// Frequency counts the frequency of each rune in a given text and returns this
// data as a FreqMap.
func Frequency(s string) FreqMap {
	m := FreqMap{}
	for _, r := range s {
		m[r]++
	}
	return m
}

// ConcurrentFrequency counts the frequency of each rune in the given strings,
// by making use of concurrency.
func ConcurrentFrequency(l []string) FreqMap {
	chans := make([]chan FreqMap, len(l))
	res := FreqMap{}

	for i, elem := range l {
		c := make(chan FreqMap)
		chans[i] = c
		go func(s string, c chan FreqMap) {
			c <- Frequency(s)
		}(elem, c)
	}

	for _, c := range chans {
		fmap := <-c
		for k, v := range fmap {
			res[k] += v
		}
	}

	return res
}
