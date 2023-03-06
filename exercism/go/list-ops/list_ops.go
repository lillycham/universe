package listops

import "sync"

// IntList is an abstraction of a list of integers which we can define methods on
type IntList []int

func (s IntList) Foldl(fn func(int, int) int, initial int) int {
	acc := initial
	for i := len(s) - 1; i >= 0; i-- {
		acc = fn(acc, s[i])
	}
	return acc
}

func (s IntList) Foldr(fn func(int, int) int, initial int) int {
	acc := initial

	for k := len(s) - 1; k >= 0; k-- {
		acc = fn(s[k], acc)
	}

	return acc
}

func (s IntList) Filter(fn func(int) bool) IntList {
	res := make(IntList, 0)
	for _, v := range s {
		if fn(v) {
			res = append(res, v)
		}
	}
	return res
}

func (s IntList) Length() int {
	ctr := 0
	for range s {
		ctr++
	}
	return ctr
}

// Concurrent Map, running each function in a goroutine & awaiting completion
func (s IntList) Map(fn func(int) int) IntList {
	res := make(IntList, len(s))
	// waitgroup
	wg := sync.WaitGroup{}

	for i, v := range s {
		wg.Add(1)
		go func(idx int, v int) {
			defer wg.Done()
			res[idx] = fn(v)
		}(i, v)
	}

	wg.Wait()
	return res
}

func (s IntList) Reverse() IntList {
	for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
		s[i], s[j] = s[j], s[i]
	}
	return s
}

func (s IntList) Append(lst IntList) IntList {
	if len(lst) == 0 {
		return s
	} else if len(s) == 0 {
		return lst
	}

	// final slice
	res := make(IntList, len(s)+len(lst))
	// populate with first slice
	copy(res, s)
	// populate with second slice
	l := len(s) // cache length
	for i, v := range lst {
		res[l+i] = v
	}

	return res
}

func (s IntList) Concat(lists []IntList) IntList {
	for _, v := range lists {
		s = s.Append(v)
	}
	return s
}
