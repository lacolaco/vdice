module vdice

import rand
import regex

pub fn roll(input string) int {
	dice := parse_dice(input) or {
		println('Error parsing dice: ${err}')
		return 0
	}

	dump(dice)

	mut total := 0
	for _ in 0 .. dice.num_dice {
		total += rand.int_in_range(1, dice.num_faces + 1) or { 0 }
	}

	if dice.modifier != 0 {
		total += dice.modifier
	}

	if dice.multiplier != 1 {
		total *= dice.multiplier
	}

	return total
}

struct Dice {
	num_dice   int
	num_faces  int
	modifier   int // + or -
	multiplier int // *
}

// parse an input string to extract the number of dice and faces
// format: "XdY" where X is the number of dice and Y is the number of faces
// e.g. "2d6" means 2 dice with 6 faces each
// e.g. "d6" means 1 die with 6 faces
// The input may also include an additive part, e.g. "2d6+1" or "2d6-1"
// e.g. "d6+1" means 1 die with 6 faces + 1
// e.g. "d6-1" means 1 die with 6 faces - 1
// The input may also include a multiplicative part, e.g. "2d6*2"
// e.g. "d6*2" means 1 die with 6 faces * 2
fn parse_dice(input string) !Dice {
	if !input.contains('d') {
		return error('Invalid dice format')
	}

	// regex pattern to match the dice notation
	mut re := regex.regex_opt(r'^(?P<dice>\d+)?d(?P<faces>\d+)\s*(?P<multiply>[\*]\d+)?\s*(?P<mod>[\+\-]\d+)?$')!
	if re.matches_string(input) == false {
		return error('Invalid dice format')
	}

	// extract the parts of the dice notation
	dice_part := re.get_group_by_name(input, 'dice')
	faces_part := re.get_group_by_name(input, 'faces')
	multiply_part := re.get_group_by_name(input, 'multiply')
	mod_part := re.get_group_by_name(input, 'mod')

	num_dice := if dice_part.len > 0 { dice_part.int() } else { 1 }
	assert num_dice > 0, 'Invalid number of dice: ${num_dice}'

	num_faces := faces_part.int()
	assert num_faces > 0, 'Invalid number of faces: ${num_faces}'

	mut modifier := 0
	if mod_part.len > 0 {
		modifier = mod_part.int()
	}

	mut multiplier := 1
	if multiply_part.len > 0 {
		multiplier = multiply_part[1..].int()
	}

	return Dice{
		num_dice:   num_dice
		num_faces:  num_faces
		modifier:   modifier
		multiplier: multiplier
	}
}
