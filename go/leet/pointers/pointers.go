package pointers

import "fmt"

func square(thing2 *[5]float64) [5]float64 {
	fmt.Printf("Memory location of thing2 array %p\n", thing2)
	for i := range thing2 {
		thing2[i] = thing2[i] * thing2[i]
	}
	return *thing2
}

func FunWithPointer() {
	var p *int32 = new(int32)
	var i int32
	fmt.Printf("p points to %v", *p)
	fmt.Printf("\ni is %v\n", i)
	p = &i
	*p = 2
	fmt.Printf("p points to %v", *p)
	fmt.Printf("\ni is %v\n", i)

	var slice = []int32{1, 2, 3}
	var sliceCopy = slice
	sliceCopy[2] = 4
	fmt.Println(slice)
	fmt.Println(sliceCopy)

	var thing1 = [5]float64{1, 2, 3, 4, 5}
	fmt.Printf("Memory location of thing1 array %p\n", &thing1)
	var result = square(&thing1)
	fmt.Println(result)
}
