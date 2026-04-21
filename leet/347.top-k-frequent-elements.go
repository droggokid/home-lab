package main

import "sort"

/*
 * @lc app=leetcode id=347 lang=golang
 *
 * [347] Top K Frequent Elements
 */

// @lc code=start
func topKFrequent(nums []int, k int) []int {
	frequency := make(map[int]int)
	for _, value := range nums {
		frequency[value]++
	}

	pairs := make([][]int, 0, len(frequency))

	for num, freq := range frequency {
		pairs = append(pairs, []int{freq, num})
	}

	sort.Slice(pairs, func(i, j int) bool {
		return pairs[i][0] > pairs[j][0]
	})

	result := make([]int, k)
	for i := 0; i <= k-1; i++ {
		result[i] = pairs[i][1]
	}

	return result
}

// @lc code=end
