package main

// O(n) solution
/*
func findMin(nums []int) int {
	rot, n := 0, len(nums)-1
	for nums[0+rot] > nums[n] {
		rot++
	}
	return nums[rot]
}
*/

func findMin(nums []int) int {
	low, high := 0, len(nums)-1
	for low < high {
		mid := low + (high-low)/2
		if nums[mid] > nums[high] {
			low = mid + 1
		} else {
			high = mid
		}
	}
	return nums[low]
}
