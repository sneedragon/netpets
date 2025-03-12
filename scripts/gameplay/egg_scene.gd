extends Node2D
var egg_exists = false
var egg_time_passed = 0.0
var egg_cracking = false

func _process(delta: float) -> void:
	if egg_exists and !egg_cracking:
		progress_egg(delta)
	elif !egg_exists:
		spawn_egg()
	
func spawn_egg():
	egg_exists = true
	$Egg/EggSprite.show()

	
func progress_egg(delta) -> void:
	if egg_time_passed < 20:
		egg_time_passed += delta
		$Egg/EggSprite.speed_scale = (egg_time_passed * egg_time_passed) / 10
		#print(egg_time_passed)
	else:
		egg_cracking = true
		$Egg/EggSprite.animation = "Cracking"
		$UI/HatchLabel.show()
		$UI/HatchButton.show()


func _on_hatch_button_pressed() -> void:
	print("tapped")
	if not $Egg/EggSprite.frame == 3:
		$Egg/EggSprite.frame += 1
		print($Egg/EggSprite.frame)
	else:
		get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_egg_button_pressed() -> void:
	print("egg")
