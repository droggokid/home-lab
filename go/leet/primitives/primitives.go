package primitives

import (
	"fmt"
	"unicode/utf8"
)

func ShowPrimitives() {
	var intNum uint = 40000
	fmt.Println(intNum)

	var floatNum float64 = 12345678.9
	fmt.Println(floatNum)

	var res = intNum + uint(floatNum)
	fmt.Println(res)

	var myString string = "Hello \nasd"
	fmt.Println(myString)
	fmt.Println(utf8.RuneCountInString(myString))

	var myRune rune = 's'
	fmt.Println(myRune)

	var intNum2 int
	fmt.Println(intNum2)

	var myVar = "text"
	fmt.Println(myVar)

	myVar2 := "abc"
	fmt.Println(myVar2)

	const myConst string = "const"
	fmt.Println(myConst)
}
