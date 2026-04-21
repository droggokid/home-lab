package interfaces

import "fmt"

type engine interface {
	milesLeft() uint8
}

type gasEngine struct {
	mpg     uint8
	gallons uint8
	owner
}

type owner struct {
	name string
}

type electricEngine struct {
	mpkwh uint8
	kwh   uint8
}

func (e gasEngine) milesLeft() uint8 {
	return e.gallons * e.mpg
}

func (e electricEngine) milesLeft() uint8 {
	return e.mpkwh * e.kwh
}

func canMakeIt(e engine, miles uint8) {
	if miles <= e.milesLeft() {
		fmt.Println("Yes")
	} else {
		fmt.Println("No")
	}
}

func FunWithInterfaces() {
	var gasEngine gasEngine = gasEngine{25, 40, owner{"Alex"}}

	var myEngine = struct {
		mpg     uint8
		gallons uint8
	}{30, 50}

	fmt.Println(gasEngine.gallons, gasEngine.mpg, gasEngine.name)
	fmt.Println(myEngine.gallons, myEngine.mpg)

	fmt.Println(gasEngine.milesLeft())

	canMakeIt(gasEngine, 254)
}
