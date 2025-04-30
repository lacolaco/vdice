module vdice

import rand
import arrays

fn testsuite_begin() {
	println('Running tests...')
	rand.seed([u32(0), u32(0)])
}

fn test_roll_simple_d3() {
	input := 'd3'
	mut results := []int{}
	for i in 0 .. 20 {
		results << roll(input)
	}
	// Check that the results are within the expected range
	for result in results {
		assert result >= 1 && result <= 3, 'Result: ${result}'
	}
}

fn test_roll_simple_2d3() {
	input := '2d3'
	mut results := []int{}
	for i in 0 .. 20 {
		results << roll(input)
	}
	// Check that the results are within the expected range
	for result in results {
		assert result >= 2 && result <= 6, 'Result: ${result}'
	}
}

fn test_roll_simple_3d3() {
	input := '3d3'
	mut results := []int{}
	for i in 0 .. 20 {
		results << roll(input)
	}
	// Check that the results are within the expected range
	for result in results {
		assert result >= 3 && result <= 9, 'Result: ${result}'
	}
}

fn test_roll_additive() {
	input := '1d3+1'
	mut results := []int{}
	for i in 0 .. 20 {
		results << roll(input)
	}
	// Check that the results are within the expected range
	for result in results {
		assert result >= 2 && result <= 4, 'Result: ${result}'
	}
}

fn test_roll_subtractive() {
	input := '1d3-1'
	mut results := []int{}
	for i in 0 .. 20 {
		results << roll(input)
	}
	// Check that the results are within the expected range
	for result in results {
		assert result >= -1 && result <= 2, 'Result: ${result}'
	}
}

fn test_roll_multiplicative() {
	input := '1d3*2'
	mut results := []int{}
	for i in 0 .. 20 {
		results << roll(input)
	}
	// Check that the results are within the expected range
	for result in results {
		assert result >= 2 && result <= 6, 'Result: ${result}'
	}
}
