package main

/*
 * @lc app=leetcode id=1979 lang=golang
 *
 * [1979] Find Greatest Common Divisor of Array
 */

// @lc code=start
func findGCD(nums []int) int {
	m, n := nums[0], nums[0]
	for i := 0; i < len(nums); i++ {
		if nums[i] < m {
			m = nums[i]
		} else if nums[i] > n {
			n = nums[i]
		}
	}

	for m > 0 {
		tmp := n % m
		n = m
		m = tmp
	}

	return n
}

// @lc code=end
