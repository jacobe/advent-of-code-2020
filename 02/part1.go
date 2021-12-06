package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func readLines(fileName string) *bufio.Scanner {
	file, _ := os.OpenFile(fileName, os.O_RDONLY, 0)
	scanner := bufio.NewScanner(file)
	return scanner
}

type Password struct {
	min      int
	max      int
	char     rune
	password string
}

func isPasswordValid(p Password) bool {
	count := strings.Count(p.password, string(p.char))
	isValid := count >= p.min && count <= p.max
	return isValid
}

func splitter(r rune) bool {
	return r == ':' || r == ' ' || r == '-'
}

func parseLine(line string) Password {
	parts := strings.FieldsFunc(line, splitter)
	min, _ := strconv.Atoi(parts[0])
	max, _ := strconv.Atoi(parts[1])
	char := rune(parts[2][0])
	password := parts[3]
	return Password{min, max, char, password}
}

func main() {
	scanner := readLines("input.txt")
	inputs := make([]Password, 0)
	for scanner.Scan() {
		line := scanner.Text()
		password := parseLine(line)
		inputs = append(inputs, password)
	}

	counter := 0
	for i := 0; i < len(inputs); i++ {
		password := inputs[i]
		if isPasswordValid(password) {
			counter++
		}
	}

	fmt.Println(counter)
}
