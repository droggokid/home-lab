package main

func maxArea(height []int) int {
	max, i, j := 0, 0, len(height)-1

	for i < j {
		if height[i] < height[j] {
			container := height[i] * (j - i)
			if container > max {
				max = container
			}
			i++
		} else {
			container := height[j] * (j - i)
			if container > max {
				max = container
			}
			j--
		}
	}

	return max
}
