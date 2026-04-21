package main

/*
 * @lc app=leetcode id=128 lang=golang
 *
 * [128] Longest Consecutive Sequence
 */

// @lc code=start
func longestConsecutive(nums []int) int {
	if len(nums) == 0 {
		return 0
	}

	m := make(map[int]bool)
	for _, v := range nums {
		m[v] = true
	}

	longest := 0

	for v := range m {
		if !m[v-1] {
			current := v
			length := 1

			for m[current+1] {
				current++
				length++
			}

			if length > longest {
				longest = length
			}
		}
	}

	return longest
}

// @lc code=end
