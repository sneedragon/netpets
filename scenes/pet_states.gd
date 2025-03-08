extends Node
	
const HUNGER_STATES = [
	{"max": 0, "value": "STARVING"},
	{"max": 25, "value": "HUNGRY"},
	{"max": 50, "value": "PECKISH"},
	{"max": 75, "value": "SATISIFED"},
	{"max": 100, "value": "FULL"},
]

func get_hunger_text():
	for state in HUNGER_STATES:
		if global.data["pet_stats"]["hunger"] <= state["max"]:
			return state["value"]
			break
			
const HAPPINESS_STATES = [
	{"max": 0, "value": "SAD"},
	{"max": 25, "value": "UNHAPPY"},
	{"max": 50, "value": "FINE"},
	{"max": 75, "value": "HAPPY"},
	{"max": 100, "value": "BLISSFUL"},
]

func get_happiness_text():
	for state in HAPPINESS_STATES:
		if global.data["pet_stats"]["happiness"] <= state["max"]:
			return state["value"]
			break
			
const SLEEP_STATES = [
	{"max": 0, "value": "EXHAUSTED"},
	{"max": 25, "value": "TIRED"},
	{"max": 50, "value": "RELAXED"},
	{"max": 75, "value": "ACTIVE"},
	{"max": 100, "value": "ENERGETIC"},
]

func get_sleep_text():
	for state in SLEEP_STATES:
		if global.data["pet_stats"]["sleep"] <= state["max"]:
			return state["value"]
			break

const HEALTH_STATES = [
	{"max": 0, "value": "SICKLY"},
	{"max": 25, "value": "WEAK"},
	{"max": 50, "value": "NORMAL"},
	{"max": 75, "value": "HEALTHY"},
	{"max": 100, "value": "VITAL"},
]
func get_health_text():
	for state in HEALTH_STATES:
		if global.data["pet_stats"]["health"] <= state["max"]:
			return state["value"]
			break
