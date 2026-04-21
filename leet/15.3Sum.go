package main

import (
	"slices"
)

func ThreeSum(nums []int) [][]int {
	res := make([][]int, 0)
	slices.Sort(nums)

	for i := range nums {
		j, k := i+1, len(nums)-1

		if i > 0 && nums[i] == nums[i-1] {
			continue
		}

		for j < k {
			if nums[j]+nums[k] > -nums[i] {
				k = k - 1
			} else if nums[j]+nums[k] < -nums[i] {
				j = j + 1
			} else {
				res = append(res, []int{nums[i], nums[j], nums[k]})
				k = k - 1
				j = j + 1

				for j < k && nums[j] == nums[j-1] {
					j = j + 1
				}

				for j < k && nums[k] == nums[k+1] {
					k = k - 1
				}
			}
		}
	}
	return res
}
