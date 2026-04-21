package main

/*
 * @lc app=leetcode id=75 lang=golang
 *
 * [75] Sort Colors
 */

// @lc code=start

// Dutch National Flag (3-pointer)
func sortColors(nums []int) {
	low, mid, high := 0, 0, len(nums)-1
	tmp := 0

	for mid <= high {
		switch nums[mid] {
		case 0:
			tmp = nums[low]
			nums[low] = 0
			nums[mid] = tmp
			low++
			mid++
		case 1:
			mid++
		default:
			tmp = nums[high]
			nums[high] = nums[mid]
			nums[mid] = tmp
			high--
		}
	}
}

// @lc code=end

// Count sort

/* func sortColors(nums []int) {
	zeros, ones, twos := 0, 0, 0
	for i := 0; i < len(nums); i++ {
		switch nums[i] {
		case 0:
			zeros++
		case 1:
			ones++
		default:
			twos++
		}
	}
	for i := 0; i < len(nums); i++ {
		if i < zeros {
			nums[i] = 0
		} else if i >= zeros && i < len(nums)-twos {
			nums[i] = 1
		} else {
			nums[i] = 2
		}
	}
} */
