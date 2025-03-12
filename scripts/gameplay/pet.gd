extends Node2D

@onready var sprite = $PetSprite

@onready var pet_manager: Node = $PetManager


func _process(delta: float) -> void:
	if !global.data["light"]:
		sprite.animation = "Sleep" + str(global.data["pet_attributes"]["pet_type"])
	else:
		sprite.animation = "Idle" + str(global.data["pet_attributes"]["pet_type"])
		
func generate_pet():
	global.data["pet_exists"] = true
	global.data["pet_alive"] = true
	global.data["light"] = true
	global.data["pet_stats"]["birth_time"] = Time.get_unix_time_from_system()
	global.data["pet_attributes"]["height"] = randf_range(0.75, 1.5)
	global.data["pet_attributes"]["width"] = randf_range(0.75, 1.5)
	global.data["pet_attributes"]["hue"] = randf_range(0.0, 1.0)
	global.data["pet_stats"]["hunger"] = 51.0
	global.data["pet_stats"]["sleep"] = 51.0
	global.data["pet_stats"]["happiness"] = 51.0
	global.data["pet_stats"]["health"] = 100.0
	global.save_data()


	
	
