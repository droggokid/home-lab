package main

/*
 * @lc app=leetcode id=53 lang=golang
 *
 * [53] Maximum Subarray
 */

// @lc code=start

// Kadane's Algorithm
func maxSubArray(nums []int) int {
	max, sum := nums[0], 0
	for i := 0; i < len(nums); i++ {
		sum += nums[i]

		if sum > max {
			max = sum
		}

		if sum < 0 {
			sum = 0
		}
	}
	return max
}

// @lc code=end

// Brute force
/* func maxSubArray(nums []int) int {
	maxSum := nums[0]
	for i := 0; i < len(nums); i++ {
		currentSum := 0
		for j := i; j < len(nums); j++ {
			currentSum += nums[j]
			if currentSum > maxSum {
				maxSum = currentSum
			}
		}
	}
	return maxSum
} */
