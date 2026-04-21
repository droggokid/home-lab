package main

import (
	"fmt"
	"strconv"
	"strings"
)

func day2part2(lines []string) {
	ranges := strings.Split(lines[0], ",")

	var interval [][]string

	res := 0

	for i := range ranges {
		interval = append(interval, strings.Split(ranges[i], "-"))
	}

	for _, u := range interval {
		start, err := strconv.Atoi(u[0])

		if err != nil {
			return
		}

		end, err := strconv.Atoi(u[1])

		if err != nil {
			return
		}

		for i := start; i <= end; i++ {
			id := strconv.Itoa(i)

			idLength := len(id)

			mid := idLength / 2

			for k := 1; k <= mid; k++ {
				if idLength%k == 0 {
					if strings.Repeat(id[:k], len(id)/k) == id {
						res += i
						break
					}
				}
			}

		}
	}
	fmt.Println(res)
}

func day2part1(lines []string) {
	ranges := strings.Split(lines[0], ",")

	var interval [][]string

	res := 0

	for i := range ranges {
		interval = append(interval, strings.Split(ranges[i], "-"))
	}

	for _, u := range interval {
		start, err := strconv.Atoi(u[0])

		if err != nil {
			return
		}

		end, err := strconv.Atoi(u[1])

		if err != nil {
			return
		}

		for i := start; i <= end; i++ {
			id := strconv.Itoa(i)

			idLength := len(id)

			if idLength%2 != 0 {
				continue
			}

			mid := idLength / 2

			if id[:mid] == id[mid:] {
				res += i
			}
		}
	}
	fmt.Println(res)
}
