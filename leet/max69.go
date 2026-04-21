package main

import (
	"strconv"
)

func maximum69Number(num int) int {
	arr := make([]int, len(strconv.Itoa(num)))
	res := 0
	for i := len(arr) - 1; i >= 0; i-- {
		arr[i] = num % 10
		num = int(num / 10)
	}
	for i := 0; i < len(arr); i++ {
		if arr[i] == 6 {
			arr[i] = 9
			break
		}
	}
	for i := 0; i < len(arr); i++ {
		res = res*10 + arr[i]
	}
	return res
}
