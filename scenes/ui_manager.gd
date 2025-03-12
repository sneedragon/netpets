extends Node

@onready var pet_states = $"../../Pet/PetStates"
@onready var pet_manager: Node = $"../../Pet/PetManager"
##TopLeft UI
@onready var hunger_meter_label: Label = $"../TopContainer/MeterContainer/HungerMeterLabel"
@onready var happy_meter_label: Label = $"../TopContainer/MeterContainer/HappyMeterLabel"
@onready var sleep_meter_label: Label = $"../TopContainer/MeterContainer/SleepMeterLabel"
@onready var health_meter_label: Label = $"../TopContainer/MeterContainer/HealthMeterLabel"
##Topright UI
@onready var coins_label: Label = $"../TopContainer/TopRightContainer/CoinsLabel"
@onready var power_label: Label = $"../TopContainer/TopRightContainer/PowerLabel"
@onready var level_label: Label = $"../TopContainer/TopRightContainer/LevelLabel"
##Buttons
@onready var food_button: Button = $"../ButtonContainer/FoodButton"
@onready var play_button: Button = $"../ButtonContainer/PlayButton"
@onready var medicine_button: Button = $"../ButtonContainer/MedicineButton"
@onready var sleep_button: Button = $"../ButtonContainer/SleepButton"
@onready var debugbutton: Button = $"../ButtonContainer/DEBUGBUTTON"


func update_meters() -> void:
	hunger_meter_label.text = pet_states.get_hunger_text()
	$"../TopContainer/MeterContainer/HungerMeterLabel/HungerBar".value = global.data["pet_stats"]["hunger"]
	happy_meter_label.text = pet_states.get_happiness_text()
	$"../TopContainer/MeterContainer/HappyMeterLabel/HappyBar".value = global.data["pet_stats"]["happiness"]
	sleep_meter_label.text = pet_states.get_sleep_text()
	$"../TopContainer/MeterContainer/SleepMeterLabel/SleepBar".value = global.data["pet_stats"]["sleep"]
	health_meter_label.text = pet_states.get_health_text()
	$"../TopContainer/MeterContainer/HealthMeterLabel/HealthBar".value = global.data["pet_stats"]["health"]
	level_label.text = "LVL " + str(pet_manager.get_pet_level() + 1)

func light_check():
	if !global.data["light"]:
		$"../../Room/Darkness".show()
		sleep_button.text = "WAKE UP"
		food_button.hide()
		play_button.hide()
		$"../../Room/BGM".volume_db = -30
		$"../../Room/BGM".pitch_scale = 0.95
		##medicine_button.hide()
	else:
		$"../../Room/Darkness".hide()
		sleep_button.text = "SLEEP"
		food_button.show()
		play_button.show()
		$"../../Room/BGM".volume_db = -20
		$"../../Room/BGM".pitch_scale = 1
		##medicine_button.show()

		
		
func _on_food_button_pressed() -> void:
	global.data["pet_stats"]["hunger"] += 25
	
func _on_play_button_pressed() -> void:
	global.data["pet_stats"]["happiness"] += 25

func _on_sleep_button_pressed() -> void:
	if global.data["light"]:
		global.data["light"] = false
		$"../../Room/Darkness".show()
		sleep_button.text = "WAKE UP"
		food_button.hide()
		play_button.hide()
		$"../../Room/BGM".volume_db = -30
		$"../../Room/BGM".pitch_scale = 0.95
		##medicine_button.hide()
	else:
		global.data["light"] = true
		$"../../Room/Darkness".hide()
		sleep_button.text = "SLEEP"
		food_button.show()
		play_button.show()
		$"../../Room/BGM".volume_db = -20
		$"../../Room/BGM".pitch_scale = 1
		##medicine_button.show()

func _on_debugbutton_pressed() -> void:
	global.data["pet_stats"]["hunger"] = 0
	global.data["pet_stats"]["happiness"] = 0
	global.data["pet_stats"]["sleep"] = 0
	global.data["pet_stats"]["health"] = 0.1
