package main

/*
 * @lc app=leetcode id=1 lang=golang
 *
 * [1] Two Sum
 */

// @lc code=start
func twoSum(nums []int, target int) []int {
	m := make(map[int]int)
	for i, num := range nums {
		complement := target - num
		if idx, exists := m[complement]; exists {
			return []int{idx, i}
		}
		m[num] = i
	}
	return nil
}

// @lc code=end
