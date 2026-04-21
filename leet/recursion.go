package main

/*func main() {
	arr := []int{2, 4, 6}
	a := max(arr)
	fmt.Printf("%d \n", a)
}*/

func sum(arr []int) int {
	if len(arr) == 0 {
		return 0
	} else if len(arr) == 1 {
		return arr[0]
	} else {
		return arr[0] + sum(arr[1:])
	}
}

func length(arr []int) int {
	if len(arr) == 0 {
		return 0
	} else {
		return 1 + length(arr[1:])
	}
}

func max(arr []int) int {
	if len(arr) == 1 {
		return arr[0]
	} else if arr[0] > max(arr[1:]) {
		return arr[0]
	} else {
		return max(arr[1:])
	}
}
