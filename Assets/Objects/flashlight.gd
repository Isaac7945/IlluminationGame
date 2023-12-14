extends Node2D

var flashlight: bool = false
@onready var spr = $Sprite2D


func _process(_delta):
	$FlashlightLight.enabled = flashlight
	
	if Input.is_action_just_pressed("primary_action"):
		flashlight = !flashlight
	
	spr.frame = 1 if flashlight else 0 # Make flashlight yellow when on
