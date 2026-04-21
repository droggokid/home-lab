package main

import (
	"bufio"
	"fmt"
	"os"
)

type Operation func([]string)

func readFileAndProcess(filename string, op Operation) {
	if len(filename) == 0 {
		return
	}

	file, err := os.Open(filename)

	if err != nil {
		fmt.Println(err)
		return
	}
	defer file.Close()

	sc := bufio.NewScanner(file)

	var lines []string

	for sc.Scan() {
		lines = append(lines, sc.Text())
	}

	if err := sc.Err(); err != nil {
		fmt.Println(err)
	}

	op(lines)
}

func readFiles(filename string) []string {
	if len(filename) == 0 {
		return []string{}
	}

	file, err := os.Open(filename)

	if err != nil {
		fmt.Println(err)
		return []string{}
	}
	defer file.Close()

	sc := bufio.NewScanner(file)

	var lines []string

	for sc.Scan() {
		lines = append(lines, sc.Text())
	}

	if err := sc.Err(); err != nil {
		fmt.Println(err)
	}

	return lines
}
