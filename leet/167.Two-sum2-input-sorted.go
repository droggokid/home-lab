package main

func twoSum2(numbers []int, target int) []int {
	left, right := 0, len(numbers)-1

	for left < right {
		if numbers[left]+numbers[right] > target {
			right = right - 1
		} else if numbers[left]+numbers[right] < target {
			left = left + 1
		} else {
			return []int{left + 1, right + 1}
		}
	}
	return []int{}
}
