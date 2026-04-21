package main

import (
	"slices"
)

type Car struct {
	pos  int
	time float64
}

func carFleet(target int, position []int, speed []int) int {
	if len(position) == 0 {
		return 0
	}

	cars := make([]Car, len(position))
	stack := make([]float64, 0)

	for i := range position {
		cars[i] = Car{
			pos:  position[i],
			time: (float64(target - position[i])) / float64(speed[i]),
		}
	}

	slices.SortFunc(cars, func(a, b Car) int {
		return b.pos - a.pos
	})

	stack = append(stack, cars[0].time)

	for i := 1; i < len(cars); i++ {
		if cars[i].time > stack[len(stack)-1] {
			stack = append(stack, cars[i].time)
		}
	}

	return len(stack)
}
