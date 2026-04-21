package functions

import (
	"errors"
	"fmt"
)

func printMe(value1 int, value2 int) {
	fmt.Printf("The result was %v with remainder %v\n", value1, value2)
}

func intDiv(numerator int, denominator int) (int, int, error) {
	var err error
	if denominator == 0 {
		err = errors.New("cannot divide by 0")
		return 0, 0, err
	}
	var result = numerator / denominator
	var remainder = numerator % denominator
	return result, remainder, err
}

func RunFunctions() {
	var result, remainder, err = intDiv(4, 0)
	/* if err != nil {
		fmt.Println(err.Error())
	} else {
		functions.PrintMe(result, remainder)
	} */
	switch {
	case err != nil:
		fmt.Println(err.Error())
	default:
		printMe(result, remainder)
	}

	switch remainder {
	case 0:
		fmt.Println("No remainder")
	case 1, 2:
		fmt.Println("Close division")
	default:
		fmt.Println("Not a close division")
	}
}
