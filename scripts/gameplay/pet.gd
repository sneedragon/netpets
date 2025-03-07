extends Node2D

@onready var sprite = $PetSprite

func _process(delta: float) -> void:
	if !global.data["light"]:
		sprite.animation = "Sleep"
	else:
		sprite.animation = "Idle"
