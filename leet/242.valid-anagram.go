package main

/*
 * @lc app=leetcode id=242 lang=golang
 *
 * [242] Valid Anagram
 */

// @lc code=start
func isAnagram(s string, t string) bool {
	if len(s) != len(t) {
		return false
	}

	m := make(map[rune]int)
	for _, char := range s {
		m[char]++
	}

	for _, char := range t {
		m[char]--
		if m[char] < 0 {
			return false
		}
	}

	return true
}

// @lc code=end
