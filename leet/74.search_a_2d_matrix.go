package main

func searchMatrix(matrix [][]int, target int) bool {
	m, n := len(matrix)-1, len(matrix[0])-1
	left_m, left_n, right_m, right_n := 0, 0, m, n
	mid_m, mid_n := 0, 0
	for left_m <= right_m {
		mid_m = left_m + (right_m-left_m)/2
		if target >= matrix[mid_m][0] && target <= matrix[mid_m][n] {
			break
		} else if target > matrix[mid_m][0] {
			left_m = mid_m + 1
		} else if target < matrix[mid_m][0] {
			right_m = mid_m - 1
		}
	}

	for left_n <= right_n {
		mid_n = left_n + (right_n-left_n)/2
		if target == matrix[mid_m][mid_n] {
			return true
		} else if target > matrix[mid_m][mid_n] {
			left_n = mid_n + 1
		} else if target < matrix[mid_m][mid_n] {
			right_n = mid_n - 1
		}
	}

	return false
}
