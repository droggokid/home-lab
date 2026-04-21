package main

import "strings"

func isValid(s string) bool {
	pairs := map[string]string{
		")": "(",
		"]": "[",
		"}": "{",
	}

	var stack []string
	characters := strings.Split(s, "")
	for _, v := range characters {
		if pair, ok := pairs[v]; ok {
			if len(stack) == 0 {
				return false
			} else if stack[len(stack)-1] != pair {
				return false
			} else {
				stack = stack[:len(stack)-1]
			}
		} else {
			stack = append(stack, v)
		}
	}

	return len(stack) == 0
}
