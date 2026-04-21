package main

/* func sortPeople(names []string, heights []int) []string {
	n := len(names)
	resArr := make([]string, n)
	heightsCopy := make([]int, n)
	namesCopy := make([]string, n)

	copy(heightsCopy, heights)
	copy(namesCopy, names)

	for i := 0; i < len(names); i++ {
		tallest := findTallest(heightsCopy)
		resArr[i] = namesCopy[tallest]
		heightsCopy = append(heightsCopy[:tallest], heightsCopy[tallest+1:]...)
		namesCopy = append(namesCopy[:tallest], namesCopy[tallest+1:]...)
	}
	return resArr
}

func findTallest(heights []int) int {
	tallest := heights[0]
	tallestIndex := 0
	for i := 1; i < len(heights); i++ {
		if heights[i] > tallest {
			tallest = heights[i]
			tallestIndex = i
		}
	}
	return tallestIndex
} */

func sortPeople(names []string, heights []int) []string {
	n := len(names)
	resArr := make([]string, n)

	for i := 0; i < len(names); i++ {
		tallest := findTallest(heights)
		resArr[i] = names[tallest]
		heights[tallest] = 0
	}
	return resArr
}

func findTallest(heights []int) int {
	tallest := heights[0]
	tallestIndex := 0
	for i := 1; i < len(heights); i++ {
		if heights[i] > tallest {
			tallest = heights[i]
			tallestIndex = i
		}
	}
	return tallestIndex
}
