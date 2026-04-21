package main

/*
 * @lc app=leetcode id=36 lang=golang
 *
 * [36] Valid Sudoku
 */

// @lc code=start
func isValidSudoku(board [][]byte) bool {
	columns := make([]map[byte]bool, 9)
	rows := make([]map[byte]bool, 9)
	squares := make([]map[byte]bool, 9)

	for i := 0; i < 9; i++ {
		columns[i] = make(map[byte]bool)
		rows[i] = make(map[byte]bool)
		squares[i] = make(map[byte]bool)
	}

	for r := 0; r < 9; r++ {
		for c := 0; c < 9; c++ {
			if board[r][c] == '.' {
				continue
			}
			val := board[r][c]
			squareIdx := (r/3)*3 + c/3

			if rows[r][val] || columns[c][val] ||
				squares[squareIdx][val] {
				return false
			}

			rows[r][val] = true
			columns[c][val] = true
			squares[squareIdx][val] = true
		}
	}
	return true
}

// @lc code=end
