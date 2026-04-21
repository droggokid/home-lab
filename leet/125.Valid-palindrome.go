package main

import (
	"regexp"
	"strings"
)

func isPalindrome(s string) bool {
	s = strings.ToLower(s)
	re, err := regexp.Compile("[^a-z0-9]+")
	if err != nil {
		return false
	}
	s = re.ReplaceAllString(s, "")

	for x, y := 0, len(s)-1; x < y; x, y = x+1, y-1 {
		if s[x] != s[y] {
			return false
		}
	}

	return true
}
