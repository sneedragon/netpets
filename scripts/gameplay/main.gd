extends Node2D

var save_timer : float
var time_progressed
const QUARTER_DAY = 0.00347222

@onready var ui_manager = $UI/UIManager
@onready var pet_manager = $Pet/PetManager
@onready var offline_handler = $OfflineHandler

func _ready() -> void:
	global.load_data()
	offline_handler.update_offline_stats()
	global.save_data()

func _process(delta: float) -> void:
	update_time(delta)
	pet_manager.update_stats(delta)
	ui_manager.update_meters()
	if save_timer >= 5.0 :
		global.save_data()
		save_timer = 0.0
		print("Data saved")

func update_time(delta : float):
	save_timer += delta
	global.data["last_time"] = Time.get_unix_time_from_system()
