extends Node2D

@onready var sprite = $PetSprite

func _process(delta: float) -> void:
	if !global.data["light"]:
		sprite.animation = "Sleep"
	else:
		sprite.animation = "Idle"
		
func generate_pet():
	global.data["pet_attributes"]["height"] = randf_range(0.75, 1.5)
	global.data["pet_attributes"]["width"] = randf_range(0.75, 1.5)
	global.data["pet_attributes"]["hue"] = randf_range(0.0, 1.0)

func display_pet():
	sprite.scale.x = 4 * global.data["pet_attributes"]["width"]
	sprite.scale.y = 4 * global.data["pet_attributes"]["height"]
	sprite.modulate = Color.from_hsv(global.data["pet_attributes"]["hue"], 1.0, 1.0)
	
