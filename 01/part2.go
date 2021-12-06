package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	file, _ := os.OpenFile("input.txt", os.O_RDONLY, 0)
	scanner := bufio.NewScanner(file)
	numbers := make([]int, 10)
	for scanner.Scan() {
		line := scanner.Text()
		number, _ := strconv.Atoi(line)
		if number != 0 {
			numbers = append(numbers, number)
		}
	}

	for i := 0; i < len(numbers); i++ {
		for j := i + 1; j < len(numbers); j++ {
			for k := j + 1; k < len(numbers); k++ {
				if i == j || j == k || i == k {
					continue
				}
				if numbers[i]+numbers[j]+numbers[k] == 2020 {
					fmt.Println(numbers[i] * numbers[j] * numbers[k])
				}
			}
		}
	}
}
