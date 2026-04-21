package main

func canConstruct(ransomNote string, magazine string) bool {
	m := make(map[int]int)
	for _, j := range magazine {
		m[int(j)] = m[int(j)] + 1
	}

	for _, j := range ransomNote {
		m[int(j)] = m[int(j)] - 1
	}

	for _, j := range m {
		if j < 0 {
			return false
		}
	}
	return true
}
