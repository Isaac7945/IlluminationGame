extends Node2D

var flashlight: bool = false
var flashlight_drain: float = 0.01
@onready var spr = $Sprite2D


func _process(_delta):
	$FlashlightLight.enabled = flashlight
	
	if Input.is_action_just_pressed("primary_action"):
		flashlight = !flashlight
	
	
	# Drain flashlight
	if flashlight:
		global.battery -= flashlight_drain
		spr.frame = 1
	else:
		spr.frame = 0
		
	# Turn flashlight off when no battery
	if global.battery <= 0:
		global.battery = 0
		flashlight = false
	
	print(global.battery)
