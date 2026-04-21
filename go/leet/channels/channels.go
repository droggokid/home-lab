package channels

import (
	"fmt"
	"math/rand"
	"time"
)

var MAX_CHICKEN_PRICE float32 = 5
var MAX_BEEF_PRICE float32 = 3

func FunWithChannels() {
	var chickenChannel = make(chan string)
	var beefChannel = make(chan string)

	var websites = []string{"walmart.com", "costco.com", "wholefoods.com"}
	for i := range websites {
		go checkChickenPrices(websites[i], chickenChannel)
		go checkBeefPrices(websites[i], beefChannel)
	}
	sendMessage(chickenChannel, beefChannel)
}

func checkChickenPrices(website string, chickenChannel chan string) {
	for {
		time.Sleep(time.Second * 1)
		var chickenPrice = rand.Float32() * 20
		if chickenPrice <= MAX_CHICKEN_PRICE {
			chickenChannel <- website
			break
		}
	}
}

func checkBeefPrices(website string, beefChannel chan string) {
	for {
		time.Sleep(time.Second * 1)
		var beefPrice = rand.Float32() * 20
		if beefPrice <= MAX_BEEF_PRICE {
			beefChannel <- website
			break
		}
	}
}

func sendMessage(chickenChannel chan string, beefChannel chan string) {
	select {
	case website := <-chickenChannel:
		fmt.Printf("Text: Found a deal on chicken at %s\n", website)
	case website := <-beefChannel:
		fmt.Printf("Email: Found a deal on beef at %s\n", website)
	}
}

/* func chillWithChannels() {
	c := make(chan int, 5)
	go process(c)
	for i := range c {
		fmt.Println(i)
		time.Sleep(time.Second * 1)
	}
}

func process(c chan int) {
	defer close(c)
	for i := 0; i < 5; i++ {
		c <- i
	}
	fmt.Println("Exiting process")
} */
