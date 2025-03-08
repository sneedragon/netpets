extends Node
const QUARTER_DAY = 0.00347222
const FULL_DAY = 0.001157407
	
func update_stats(delta : float):
	update_hunger(delta)
	update_happiness(delta)
	update_sleep(delta)
	update_health(delta)
	
func update_hunger(delta : float):
	global.data["pet_stats"]["hunger"] -= (delta * hunger_calculation())
	global.data["pet_stats"]["hunger"] = clamp(global.data["pet_stats"]["hunger"], 0, 100)
	
func hunger_calculation():
	return QUARTER_DAY
	
	
func update_happiness(delta):
	global.data["pet_stats"]["happiness"] -= (delta * happiness_calculation())
	global.data["pet_stats"]["happiness"] = clamp(global.data["pet_stats"]["happiness"], 0, 100)
	
func happiness_calculation():
	return QUARTER_DAY
	
func update_sleep(delta):
	global.data["pet_stats"]["sleep"] -= (delta * sleep_calculation())
	global.data["pet_stats"]["sleep"] = clamp(global.data["pet_stats"]["sleep"], 0, 100)
	
func sleep_calculation():
	var sleep_rate
	if global.data["light"]:
		sleep_rate = QUARTER_DAY
	elif !global.data["light"]: #if lights are off, sleep bar up
		sleep_rate = -(QUARTER_DAY * 2)
	return sleep_rate
	
func update_health(delta):
	health_calculation()
	global.data["pet_stats"]["health"] -= (health_calculation() * delta) + (FULL_DAY / 14)
	global.data["pet_stats"]["health"] = clamp(global.data["pet_stats"]["health"], 0, 100)

func health_calculation():
	var health_factor = 1.0
	var health = global.data["pet_stats"]["health"]
	var hunger = global.data["pet_stats"]["hunger"]
	var sleep = global.data["pet_stats"]["sleep"]
	var happiness = global.data["pet_stats"]["happiness"]
	if hunger == 0:
		health_factor *= (1 + (FULL_DAY / 2))
	if happiness == 0:
		health_factor *= (1 + (FULL_DAY / 4))
	if sleep == 0:
		health_factor *= (1 + (FULL_DAY / 2))
	health_factor -= 1
	return health_factor
	
func get_pet_level():
	return floor((Time.get_unix_time_from_system() - global.data["pet_stats"]["birth_time"]) / 86400)
