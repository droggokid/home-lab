package main

import "fmt"

func main() {
	// res := carFleet(12, []int{10, 8, 0, 5, 3}, []int{2, 4, 1, 1, 3})
	// res := maxArea([]int{1, 8, 6, 2, 5, 4, 8, 3, 7})
	// res := trap([]int{0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1})
	// res := searchMatrix([][]int{{1, 3, 5, 7}, {10, 11, 16, 20}, {23, 30, 34, 60}}, 16)
	// res := minEatingSpeed([]int{3, 6, 7, 11}, 8)
	// res := findMin([]int{3, 4, 5, 1, 2})
	res := searchRotArray([]int{4, 5, 6, 7, 0, 1, 2}, 0)
	fmt.Println(res)
}

// Binary search 704
/* func search(nums []int, target int) int {
	lo := 0
	hi := len(nums)
	for {
		if lo < hi {
			m := lo + (hi-lo)/2
			if nums[m] == target {
				return m
			} else if nums[m] > target {
				hi = m
			} else {
				lo = m + 1
			}
		} else {
			return -1
		}
	}
} */

// 2529. Maximum Count of Positive Integer and Negative Integer O(n)
/* func maximumCount(nums []int) int {
	pos, neg := 0, 0
	for _, v := range nums {
		if v > 0 {
			pos++
		} else if v != 0 {
			neg++
		}
	}
	if pos > neg {
		return pos
	} else {
		return neg
	}
} */

func maximumCount(nums []int) int {
	lo1, hi1 := 0, len(nums)

	for lo1 < hi1 {
		m1 := lo1 + (hi1-lo1)/2
		if nums[m1] >= 0 {
			hi1 = m1
		} else {
			lo1 = m1 + 1
		}
	}
	neg := lo1
	lo2, hi2 := 0, len(nums)
	for lo2 < hi2 {
		m2 := lo2 + (hi2-lo2)/2
		if nums[m2] > 0 {
			hi2 = m2
		} else {
			lo2 = m2 + 1
		}
	}
	pos := len(nums) - lo2
	if pos > neg {
		return pos
	} else {
		return neg
	}
}
