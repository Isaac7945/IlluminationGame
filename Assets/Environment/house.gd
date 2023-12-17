extends Area2D

@onready var house_sprite = $HouseSprite
@onready var window_light = $WindowLight
@onready var house_window = $HouseWindow
@onready var enemies = $Enemies
var lights = true:
	set(value):
		lights = value
		if value:
			house_window.frame = 0
			window_light.enabled = true
		else:
			house_window.frame = 1
			window_light.enabled = false


var player: CharacterBody2D
@export var enemy_scene: PackedScene

func _ready():
	print("house: ", position)
	
	player = get_tree().get_first_node_in_group('Player')
	house_sprite.frame = 0
	window_light.enabled = true
	
	await get_tree().create_timer(2.5).timeout
	flicker()


func _on_body_entered(body):
	house_sprite.play("open")
	
	
func hit():
	print('house hit')

func flicker():
	lights = false
	await get_tree().create_timer(0.1).timeout
	lights = true
	await get_tree().create_timer(0.25).timeout
	lights = false
	await get_tree().create_timer(0.1).timeout
	lights = true

func _on_despawn_area_body_entered(body):
	if body == player:
		body.queue_free()
		house_lights()

func house_lights():
	house_window.frame = 1
	window_light.enabled = true
	global.game_win.emit()

