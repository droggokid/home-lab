package kata

import (
	"math"
)

func TwoSum(numbers []int, target int) ([2]int, [2]int) {
	var res [2]int
	for i, v := range numbers {
		for o, b := range numbers {
			if i != o && v+b == target {
				res[0], res[1] = i, o
				return res, res
			}
		}
	}
	return res, res
}

func sortedSquares(nums []int) []int {
	for i, v := range nums {
		nums[i] = int(math.Pow(float64(v), 2))
	}
	return nums
}

func main() {
	res1, res2 := TwoSum([]int{2, 7, 11, 15}, 9)
	println(res1[0], res1[1])
	println(res2[0], res2[1])

}
