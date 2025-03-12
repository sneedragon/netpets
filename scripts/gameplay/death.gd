extends Node2D
@onready var sprite: AnimatedSprite2D = $PetSprite
@onready var goodbye_label: Label = $GoodbyeLabel
@onready var format_button: Button = $ButtonContainer/FormatButton
@onready var to_egg_button: Button = $ButtonContainer/ToEggButton



var dying_timer: float = 30.0

func _ready() -> void:
	print("DEATH SECEN")
	global.load_data()
	display_pet()
	
func _process(delta: float) -> void:
	if global.data["pet_exists"] == true:
		if dying_timer > 20 and dying_timer < 25:
			goodbye_label.show()
			goodbye_label.text = "I don't feel\nso good..."
		elif dying_timer < 20:
			goodbye_label.hide()
			if dying_timer > 10:
				goodbye_label.text = "This is it..."
				goodbye_label.show()
			elif dying_timer > 5:
				goodbye_label.hide()
		if dying_timer > 0:
			dying_timer -= delta
			sprite.speed_scale -= (delta / 30)
			print(sprite.speed_scale)
		else:
			pet_died()
	else:
		return
		

func display_pet():
	sprite.scale.x = 4 * global.data["pet_attributes"]["width"]
	sprite.scale.y = 4 * global.data["pet_attributes"]["height"]
	sprite.modulate = Color.from_hsv(global.data["pet_attributes"]["hue"], 1.0, 1.0)
	var age_factor = 1 * clamp((1 * ((((float(((Time.get_unix_time_from_system() - global.data["pet_stats"]["birth_time"])) / 86400) / 25) + 0.5)))), 0.1, 1.2)
	sprite.scale *= age_factor
	sprite.scale.x = clamp(sprite.scale.x, 1, 10)
	sprite.scale.y = clamp(sprite.scale.y, 1, 10)
	print("SPRITE SCALE" + str(sprite.scale))
	sprite.animation = "Dying" + global.data["pet_attributes"]["pet_type"]
	
func pet_died():
	global.data["pet_exists"] = false
	global.save_data()
	goodbye_label.text = "Goodbye..."
	goodbye_label.show()
	await get_tree().create_timer(5.0).timeout
	print("pet died")
	sprite.animation = "Dead" + global.data["pet_attributes"]["pet_type"]
	await get_tree().create_timer(3.0).timeout
	goodbye_label.text = "The data for \n" + global.data["pet_attributes"]["pet_type"] + "\n has become corrupted."
	format_button.show()

func _on_format_button_pressed() -> void:
	format_button.hide()
	sprite.hide()
	sprite = $GraveSprite
	sprite.show()
	display_pet()
	sprite.animation = "Dying" + global.data["pet_attributes"]["pet_type"]
	await get_tree().create_timer(3.0).timeout
	to_egg_button.show()

func _on_to_egg_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title.tscn")
