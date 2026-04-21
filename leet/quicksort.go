package main

import "math/rand"

func sortArray(nums []int) []int {
	var less, greater []int
	if len(nums) < 2 {
		return nums
	} else {
		pivotIndex := len(nums) / 2
		pivot := nums[pivotIndex]
		for i := 0; i < len(nums); i++ {
			if i == pivotIndex {
				continue
			} else if nums[i] <= pivot {
				less = append(less, nums[i])
			} else if nums[i] > pivot {
				greater = append(greater, nums[i])
			}
		}
		result := append(sortArray(less), pivot)
		result = append(result, sortArray(greater)...)
		return result
	}
}

func partition(arr []int, low, high int) int {
	randomIndex := low + rand.Intn(high-low+1)

	arr[randomIndex], arr[high] = arr[high], arr[randomIndex]
	pivot := arr[high]
	i := low
	for j := low; j < high; j++ {
		if arr[j] < pivot {
			arr[i], arr[j] = arr[j], arr[i]
			i++
		}
	}
	arr[i], arr[high] = arr[high], arr[i]
	return i
}

func quicksort(arr []int, low, high int) []int {
	if low < high {
		p := partition(arr, low, high)
		quicksort(arr, low, p-1)
		quicksort(arr, p+1, high)
	}
	return arr
}

func quicksortStart(arr []int) []int {
	return quicksort(arr, 0, len(arr)-1)
}
