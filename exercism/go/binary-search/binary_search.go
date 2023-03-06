package binarysearch

func SearchInts(list []int, key int) int {
	// if the list is empty, return -1
	if len(list) == 0 {
		return -1
	}

	// divide the list in half
	mid := len(list) / 2

	// if the key is equal to the middle value, return the position
	if key == list[mid] {
		return mid
	}

	// if the key is less than the middle value, search the left half
	if key < list[mid] {
		pos := SearchInts(list[:mid], key)
		if pos == -1 {
			return -1
		}
		return pos
	} else {
		// if the key is greater than the middle value, search the right half
		pos := SearchInts(list[mid+1:], key)
		if pos == -1 {
			return -1
		}
		return pos + mid + 1
	}
}
