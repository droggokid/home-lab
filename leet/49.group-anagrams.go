package main

/*
 * @lc app=leetcode id=49 lang=golang
 *
 * [49] Group Anagrams
 */

// @lc code=start
func groupAnagrams(strs []string) [][]string {
	res := make(map[[26]int][]string)
	for _, word := range strs {
		var count [26]int
		for _, char := range word {
			count[char-'a']++
		}
		res[count] = append(res[count], word)
	}

	var result [][]string
	for _, i := range res {
		result = append(result, i)
	}
	return result
}

// @lc code=end
