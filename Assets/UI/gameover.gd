extends CanvasLayer

var win = false
@onready var label = $MarginContainer/VBoxContainer/Label


func _ready():
	if win:
		label.text = "You WIN!"

func _on_retry_button_button_up():
	global.battery = global.battery_max
	global.spawn_rate = 10
	global.zap_charge = 0
	global.hp = 3
	get_tree().change_scene_to_file("res://Assets/Levels/level_one.tscn")
