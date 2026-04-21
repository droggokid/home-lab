package main

func gcd(a int, b int) int {
	if a == 0 {
		return b
	} else if b == 0 {
		return a
	} else {
		longDiv := a / b
		remainder := a - (b * longDiv)
		return gcd(b, remainder)
	}
}
