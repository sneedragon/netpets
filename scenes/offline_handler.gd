extends Node

@onready var ui_manager: Node = $"../UI/UIManager"
@onready var pet_manager: Node = $"../Pet/PetManager"


const QUARTER_DAY = 0.00347222
const FULL_DAY = 0.001157407
var time_passed
var current_time

func update_offline_stats():
	ui_manager.light_check()
	"""

	time_progressed = ((Time.get_unix_time_from_system() - global.data["last_time"]) * QUARTER_DAY)
	global.data["pet_stats"]["hunger"] -= time_progressedf
	global.data["pet_stats"]["happiness"] -= time_progressed
	sleep_progress()
	"""
	if not global.data.has("last_time") or global.data["last_time"] <= 0: #prevent errors
		return
		
	current_time = Time.get_unix_time_from_system()
	time_passed = current_time - global.data["last_time"]
	
	if time_passed <= 0: #prevent error
		return
		
	var hunger_time_to_zero = global.data["pet_stats"]["hunger"] / pet_manager.hunger_calculation()
	var happiness_time_to_zero = global.data["pet_stats"]["happiness"] / pet_manager.happiness_calculation()
	var sleep_rate = pet_manager.sleep_calculation()
	var sleep_time_to_zero
	if sleep_rate > 0:
		sleep_time_to_zero = (global.data["pet_stats"]["sleep"] / abs(sleep_rate))
	else:
		sleep_time_to_zero = INF
	var first_zero_time = min(hunger_time_to_zero, min(happiness_time_to_zero, sleep_time_to_zero))
	
	if first_zero_time >= time_passed:
		pet_manager.update_stats(time_passed)
	else:
		pet_manager.update_stats(first_zero_time)
		var remaining_time = time_passed - first_zero_time
		while remaining_time > 0:
			var time_step = min(remaining_time, 1.0)
			pet_manager.update_hunger(time_step)
			pet_manager.update_happiness(time_step)
			pet_manager.update_sleep(time_step)
			var health_factor = pet_manager.health_calculation()
			global.data["pet_stats"]["health"] -= (health_factor * time_step) + (FULL_DAY / 14)
			remaining_time -= time_step
	for stat in ["hunger", "happiness", "sleep", "health"]:
		global.data["pet_stats"][stat] = clamp(global.data["pet_stats"][stat], 0, 100)
	print("OFFLINE RESULT: ", global.data)
