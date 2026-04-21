package main

// O(n*m)
/* func setZeroes(matrix [][]int) {
	for i := 0; i < len(matrix); i++ {
		for p := 0; p < len(matrix[i]); p++ {
			if matrix[i][p] == 0 {
				markColumn(p, matrix)
				markRow(i, matrix)
			}
		}
	}
	for i := 0; i < len(matrix); i++ {
		for p := 0; p < len(matrix[i]); p++ {
			if matrix[i][p] == -10 {
				matrix[i][p] = 0
			}
		}
	}

}

func markColumn(p int, matrix [][]int) {
	for i := 0; i < len(matrix); i++ {
		if matrix[i][p] != 0 {
			matrix[i][p] = -10
		}
	}
}

func markRow(i int, matrix [][]int) {
	for p := 0; p < len(matrix[i]); p++ {
		if matrix[i][p] != 0 {
			matrix[i][p] = -10
		}
	}
}
*/

func setZeroes(matrix [][]int) {
	m, n := len(matrix), len(matrix[0])
	row := make([]bool, m)
	column := make([]bool, n)

	for i := 0; i < m; i++ {
		for p := 0; p < n; p++ {
			if matrix[i][p] == 0 {
				row[i], column[p] = true, true
			}
		}
	}

	for i := 0; i < m; i++ {
		for p := 0; p < n; p++ {
			if row[i] || column[p] {
				matrix[i][p] = 0
			}
		}
	}
}
