package main

import (
	"fmt"
	"strconv"
)

func day1part2(lines []string) {
	dial, res := 50, 0

	for _, s := range lines {
		letter := s[0]
		number, err := strconv.Atoi(s[1:])

		if err != nil {
			fmt.Println(err)
			return
		}

		if letter == 'R' {
			res += (dial + number) / 100
			dial = (dial + number) % 100

		} else {
			if number > dial {
				res += (number - dial + 99) / 100
			}
			dial = ((dial-number)%100 + 100) % 100
		}

		if dial == 0 {
			res++
		}
	}

	fmt.Println(res)
}

func day1part1(lines []string) {
	dial, res := 50, 0

	for _, s := range lines {
		letter := s[0]
		number, err := strconv.Atoi(s[1:])

		if err != nil {
			fmt.Println(err)
			return
		}

		if letter == 'R' {
			if dial+number > 99 {
				dial = (dial + number) % 100

			} else {
				dial += number
			}
		} else {
			if dial-number < 0 {
				dial = (dial - number + 100) % 100
			} else {
				dial -= number
			}
		}

		if dial == 0 {
			res++
		}
	}

	fmt.Println(res)
}
