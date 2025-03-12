extends Node

@onready var sprite: AnimatedSprite2D = $"../PetSprite"
@onready var pet_manager: Node = $"../PetManager"

func display_pet():
	sprite.scale.x = 4 * global.data["pet_attributes"]["width"]
	sprite.scale.y = 4 * global.data["pet_attributes"]["height"]
	sprite.modulate = Color.from_hsv(global.data["pet_attributes"]["hue"], 1.0, 1.0)
	var age_factor = 1 * clamp((1 * ((((float(pet_manager.get_pet_level()) / 25) + 0.5)))), 0.1, 1.2)
	sprite.scale *= age_factor
	sprite.scale.x = clamp(sprite.scale.x, 1, 10)
	sprite.scale.y = clamp(sprite.scale.y, 1, 10)
	print("SPRITE SCALE" + str(sprite.scale))
