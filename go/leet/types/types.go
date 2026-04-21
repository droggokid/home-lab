package types

import (
	"fmt"
	"strings"
)

func FunWithTypes() {
	var myString = "Søndag"
	var index = myString[1]
	fmt.Printf("%v, %T \n", index, index)
	for i, v := range myString {
		fmt.Println(i, v)
	}
	fmt.Printf("\nThe length of the string is %v\n\n", len(myString))

	var myString2 = []rune("Søndag")
	var index2 = myString2[1]
	fmt.Printf("%v, %T \n", index2, index2)
	for i, v := range myString2 {
		fmt.Println(i, v)
	}
	fmt.Printf("\nThe length of the string is %v\n", len(myString2))

	var myRune = 'a'
	fmt.Printf("\nMy Rune = %v\n", myRune)

	var strSlice = []string{"a", "b", "c"}
	var catStr = ""

	for i := range strSlice {
		catStr += strSlice[i]
	}
	fmt.Println(catStr)

	var strBuilder strings.Builder
	for i := range strSlice {
		strBuilder.WriteString(strSlice[i])
	}
	catStr = strBuilder.String()
	fmt.Println(catStr)
}
