package arrays

import (
	"fmt"
	"time"
)

func FunWithArrays() {
	var intArr [3]int32
	intArr[1] = 123
	fmt.Println(intArr[1])
	fmt.Println(intArr[0:3])

	fmt.Println(&intArr[0])
	fmt.Println(&intArr[1])
	fmt.Println(&intArr[2])

	var intArr2 [3]int32 = [...]int32{1, 2, 3}
	fmt.Println(intArr2)

	intSlice := []int32{4, 5, 6}
	fmt.Printf("The length is %v with capacity %v", len(intSlice), cap(intSlice))

	intSlice = append(intSlice, 7)
	fmt.Printf("\nThe length is %v with capacity %v\n", len(intSlice), cap(intSlice))

	var intSlice2 []int32 = []int32{8, 9}
	intSlice = append(intSlice, intSlice2...)
	fmt.Printf("The length is %v with capacity %v\n", len(intSlice), cap(intSlice))

	var intSlice3 []int32 = make([]int32, 3, 8)
	fmt.Printf("The length is %v with capacity %v\n", len(intSlice3), cap(intSlice3))

	fmt.Println("\nMaps:")

	var myMap map[string]uint8 = make(map[string]uint8)
	fmt.Println(myMap)

	myMap2 := map[string]uint8{"Adam": 23, "Alice": 45, "Arthur": 60}
	fmt.Println(myMap2)
	fmt.Println(myMap2["Adam"])

	delete(myMap2, "Adam")
	fmt.Println(myMap2)
	fmt.Println(myMap2["Adam"])

	var age, ok = myMap2["Jason"]
	if ok {
		fmt.Printf("The age is %v", age)
	} else {
		fmt.Println("Invalid Name")
	}

	for name := range myMap2 {
		fmt.Printf("Age: %v \n", myMap2[name])
	}
}

func Loop() {
	n := 1000000
	var testSlice = []int{}
	var testSlice2 = make([]int, 0, n)

	fmt.Printf("Total time without preallocation: %v \n", timeLoop(testSlice, n))
	fmt.Printf("Total time with preallocation: %v \n", timeLoop(testSlice2, n))
}

func timeLoop(slice []int, n int) time.Duration {
	var t0 = time.Now()
	for len(slice) < n {
		slice = append(slice, 1)
	}
	return time.Since(t0)
}
