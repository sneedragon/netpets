extends Node2D

var save_timer : float
var time_progressed
const QUARTER_DAY = 0.00347222

func _ready() -> void:
	global.load_data()
	progress_time()
	global.save_data()

func _process(delta: float) -> void:
	update_time(delta)
	update_hunger(delta)
	update_happiness(delta)
	update_sleep(delta)
	update_health()
	update_meters()
	if save_timer >= 5.0 :
		global.save_data()
		save_timer = 0.0
		print("Data saved")
		
func progress_time():
	light_check()
	time_progressed = ((Time.get_unix_time_from_system() - global.data["last_time"]) * QUARTER_DAY)
	global.data["pet_stats"]["hunger"] -= time_progressed
	global.data["pet_stats"]["happiness"] -= time_progressed
	sleep_progress()
	
func sleep_progress():
	if global.data["light"]:
		global.data["pet_stats"]["sleep"] -= (time_progressed / 2)
	elif !global.data["light"]:
		global.data["pet_stats"]["sleep"] += (time_progressed)
	
func update_time(delta : float):
	save_timer += delta
	global.data["last_time"] = Time.get_unix_time_from_system()
	
func update_hunger(delta : float):
	global.data["pet_stats"]["hunger"] -= (delta * QUARTER_DAY)
	global.data["pet_stats"]["hunger"] = clamp(global.data["pet_stats"]["hunger"], 0, 100)
	hunger_states_text()
	
	
func update_happiness(delta):
	global.data["pet_stats"]["happiness"] -= (delta * QUARTER_DAY)
	global.data["pet_stats"]["happiness"] = clamp(global.data["pet_stats"]["happiness"], 0, 100)
	happiness_states_text()
	
func update_sleep(delta):
	if global.data["light"]:
		global.data["pet_stats"]["sleep"] -= (delta * 0.00173611)
	elif !global.data["light"]:
		global.data["pet_stats"]["sleep"] += (delta * 0.00173611 * 2)
	global.data["pet_stats"]["sleep"] = clamp(global.data["pet_stats"]["sleep"], 0, 100)
	sleep_states_text()
	
func update_health():
	pass
	
const HUNGER_STATES = [
	{"max": 0, "value": "STARVING"},
	{"max": 25, "value": "HUNGRY"},
	{"max": 50, "value": "PECKISH"},
	{"max": 75, "value": "SATISIFED"},
	{"max": 100, "value": "FULL"},
]
var hunger_text : String

func hunger_states_text():
	for state in HUNGER_STATES:
		if global.data["pet_stats"]["hunger"] <= state["max"]:
			hunger_text = state["value"]
			break
			
const HAPPINESS_STATES = [
	{"max": 0, "value": "SAD"},
	{"max": 25, "value": "UNHAPPY"},
	{"max": 50, "value": "FINE"},
	{"max": 75, "value": "HAPPY"},
	{"max": 100, "value": "BLISSFUL"},
]
var happiness_text : String

func happiness_states_text():
	for state in HAPPINESS_STATES:
		if global.data["pet_stats"]["happiness"] <= state["max"]:
			happiness_text = state["value"]
			break
			
const SLEEP_STATES = [
	{"max": 0, "value": "EXHAUSTED"},
	{"max": 25, "value": "TIRED"},
	{"max": 50, "value": "RELAXED"},
	{"max": 75, "value": "ACTIVE"},
	{"max": 100, "value": "ENERGETIC"},
]
var sleep_text : String

func sleep_states_text():
	for state in SLEEP_STATES:
		if global.data["pet_stats"]["sleep"] <= state["max"]:
			sleep_text = state["value"]
			break
		
func update_meters():
	$UI/TopContainer/MeterContainer/HungerMeterLabel.text = hunger_text
	$UI/TopContainer/MeterContainer/HappyMeterLabel.text = happiness_text
	$UI/TopContainer/MeterContainer/SleepMeterLabel.text = sleep_text
	$UI/TopContainer/MeterContainer/HealthMeterLabel.text = "HEALTH: " + str(int(global.data["pet_stats"]["health"]))
	
func _on_food_button_pressed() -> void:
	global.data["pet_stats"]["hunger"] += 25
	
func _on_play_button_pressed() -> void:
	global.data["pet_stats"]["happiness"] += 25

func _on_sleep_button_pressed() -> void:
	if global.data["light"]:
		global.data["light"] = false
		$Room/Darkness.show()
		$UI/ButtonContainer/SleepButton.text = "WAKE UP"
		$UI/ButtonContainer/FoodButton.hide()
		$UI/ButtonContainer/PlayButton.hide()
		$UI/ButtonContainer/MedicineButton.hide()
	else:
		global.data["light"] = true
		$Room/Darkness.hide()
		$UI/ButtonContainer/SleepButton.text = "SLEEP"
		$UI/ButtonContainer/FoodButton.show()
		$UI/ButtonContainer/PlayButton.show()
		##$UI/ButtonContainer/MedicineButton.show()
	
func light_check():
	if !global.data["light"]:
		$Room/Darkness.show()
		$UI/ButtonContainer/SleepButton.text = "WAKE UP"
		$UI/ButtonContainer/FoodButton.hide()
		$UI/ButtonContainer/PlayButton.hide()
		$UI/ButtonContainer/MedicineButton.hide()
	else:
		$Room/Darkness.hide()
		$UI/ButtonContainer/SleepButton.text = "SLEEP"
		$UI/ButtonContainer/FoodButton.show()
		$UI/ButtonContainer/PlayButton.show()
		##$UI/ButtonContainer/MedicineButton.show()
