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


func update_meters():
	hunger_meter_label.text = pet_states.get_hunger_text()
	happy_meter_label.text = pet_states.get_happiness_text()
	sleep_meter_label.text = pet_states.get_sleep_text()
	health_meter_label.text = pet_states.get_health_text()
	level_label.text = "LVL " + str(pet_manager.get_pet_level())

func light_check():
	if !global.data["light"]:
		$"../../Room/Darkness".show()
		sleep_button.text = "WAKE UP"
		food_button.hide()
		play_button.hide()
		##medicine_button.hide()
	else:
		$"../../Room/Darkness".hide()
		sleep_button.text = "SLEEP"
		food_button.show()
		play_button.show()
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
		##medicine_button.hide()
	else:
		global.data["light"] = true
		$"../../Room/Darkness".hide()
		sleep_button.text = "SLEEP"
		food_button.show()
		play_button.show()
		##medicine_button.show()


func _on_debugbutton_pressed() -> void:
	global.data["pet_stats"]["hunger"] = 0
	global.data["pet_stats"]["happiness"] = 0
	global.data["pet_stats"]["sleep"] = 0
	global.data["pet_stats"]["health"] = 50.01
