package generics

import (
	"encoding/json"
	"fmt"
	"os"
)

type information[T contactInfo | purchaseInfo] struct {
	Info T
}

type contactInfo struct {
	Name  string
	Email string
}

type purchaseInfo struct {
	Name   string
	Price  float32
	Amount int
}

func FunWithGenerics() {
	var contacts []contactInfo = loadJSON[contactInfo]("./generics/contactInfo.json")

	if len(contacts) == 0 {
		fmt.Println("No contacts found")
		return
	}

	var info information[contactInfo] = information[contactInfo]{
		Info: contacts[0],
	}
	prettyJSON, _ := json.MarshalIndent(info, "", "  ")
	fmt.Println(string(prettyJSON))
}

func loadJSON[T contactInfo | purchaseInfo](filepath string) []T {
	data, _ := os.ReadFile(filepath)

	var loaded = []T{}
	json.Unmarshal(data, &loaded)

	return loaded
}

/* func FunWithGenerics() {
	var intSlice = []int{1, 2, 3}
	var float32Slice = []float32{1, 2, 3}
	fmt.Println(sumSlice(intSlice))
	fmt.Println(sumSlice(float32Slice))
	fmt.Println(isEmpty(float32Slice))
}

func sumSlice[T int | float32](slice []T) T {
	var sum T
	for _, v := range slice {
		sum += v
	}
	return sum
}

func isEmpty[T any](slice []T) bool {
	return len(slice) == 0
} */
