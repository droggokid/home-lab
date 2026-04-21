package main

func minEatingSpeed(piles []int, h int) int {
	low, high := 1, findMax(piles)
	k := 0
	for low < high {
		k = 0
		mid := low + (high-low)/2

		for i := range piles {
			k += (piles[i] + mid - 1) / mid
		}

		if k > h {
			low = mid + 1
		} else if k <= h {
			high = mid
		}
	}
	return low
}

func findMax(piles []int) int {
	max := 0
	for _, v := range piles {
		if v > max {
			max = v
		}
	}
	return max
}
