extends Node

var path : String = "user://save.txt"

var data : Dictionary = {
	"last_time" : 0,
	"light" : true,
	"coins" : 0,
	"pet_stats" : {
		"birth_time" : 0.0,
		"age" : 0.0,
		"hunger" : 100.0,
		"happiness" : 0.0,
		"health" : 0.0,
		"sleep": 0.0
	}
}

func save_data() -> void:
	var file : FileAccess = FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		print("couldn't save? ", FileAccess.get_open_error())
		return
	var game_data : Dictionary = {
		"data" : data
	}
	file.store_var(game_data)
	file.close()
	print("Saved to ", ProjectSettings.globalize_path(path))
	print(data)

func load_data() -> void:
	print("loading data")
	if !FileAccess.file_exists(path):
		print("No data")
	var file : FileAccess = FileAccess.open(path, FileAccess.READ)
	if file == null:
		print("couldn't load?", FileAccess.get_open_error())
		return
	var game_data : Variant = file.get_var()
	if game_data != null and "data" in game_data:
		data = game_data["data"]
		print("loaded data: ", data)
	else:
		print("Failed to read data")
	file.close()
	
