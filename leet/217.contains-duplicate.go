package main

/*
 * @lc app=leetcode id=217 lang=golang
 *
 * [217] Contains Duplicate
 */

// @lc code=start
func containsDuplicate(nums []int) bool {
	m := make(map[int]bool)
	for _, i := range nums {
		if m[i] {
			return true
		}
		m[i] = true
	}
	return false
}

// @lc code=end
