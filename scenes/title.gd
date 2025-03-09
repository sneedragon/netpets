extends Node2D

func _ready() -> void:
	if !FileAccess.file_exists(global.path):  ## DONT FORGET TO ADD !
		print("No data")
		on_first_launch()
	elif !global.data["pet_exists"]:
		print("Found Pet, loading")
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	else:
		print("No pet, preparing eggs")
		get_tree().change_scene_to_file("res://scenes/egg_scene.tscn")

func on_first_launch():
	await get_tree().create_timer(5.0).timeout
	$LoadingLabel.hide()
	$Intro/VBoxContainer/FirstButton.show()
	
func _on_first_button_pressed() -> void:
	$Intro/VBoxContainer/IntroLabel.show()
	$Intro/VBoxContainer/FirstButton.hide()
	await get_tree().create_timer(2.0).timeout
	$Intro/VBoxContainer/OKButton1.show()


func _on_ok_button_1_pressed() -> void:
	$Intro/VBoxContainer/OKButton1.hide()
	$Intro/VBoxContainer/IntroLabel.hide()
	await get_tree().create_timer(2.0).timeout
	$Intro/VBoxContainer/IntroLabel.text = "WILL YOU CARE\nFOR IT?"
	$Intro/VBoxContainer/IntroLabel.show()
	await get_tree().create_timer(2.0).timeout
	$Intro/VBoxContainer/OKButton2.show()


func _on_ok_button_2_pressed() -> void:
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://scenes/egg_scene.tscn")
