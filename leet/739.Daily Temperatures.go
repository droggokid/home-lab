package main

func dailyTemperatures(temperatures []int) []int {
	var stack []int
	res := make([]int, len(temperatures))

	for i, v := range temperatures {
		res[i] = 0

		if len(stack) > 0 && temperatures[stack[len(stack)-1]] < v {
			for len(stack) > 0 && temperatures[stack[len(stack)-1]] < v {
				res[stack[len(stack)-1]] = i - stack[len(stack)-1]
				stack = stack[:len(stack)-1]
			}
		} else if i+1 < len(temperatures) && v < temperatures[i+1] {
			res[i] = 1
		}

		stack = append(stack, i)
	}
	return res
}
