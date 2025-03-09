extends Node

var path : String = "user://data"

var data : Dictionary = {
	"pet_exists": false,
	"pet_alive": false,
	"last_time" : 0,
	"light" : true,
	"coins" : 0,
	"pet_stats" : {
		"birth_time" : 0.0,
		"age" : 0.0,
		"hunger" : 50.0,
		"happiness" : 50.0,
		"health" : 100.0,
		"sleep": 50.0
	},
	"pet_attributes" : {
		"color": 1.0,
		"width": 1.0,
		"height": 1.0,
	},
	"first_launch" : true,
	"data_version": 1
}
var default_data: Dictionary = {
	"pet_alive": false,
	"last_time" : 0,
	"light" : true,
	"coins" : 0,
	"pet_stats" : {
		"birth_time" : 0.0,
		"age" : 0.0,
		"hunger" : 50.0,
		"happiness" : 50.0,
		"health" : 100.0,
		"sleep": 50.0
	},
	"pet_attributes" : {
		"color": 1.0,
		"width": 1.0,
		"height": 1.0,
	},
	"first_launch" : true,
	"data_version": 1
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
		data = default_data
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
	
