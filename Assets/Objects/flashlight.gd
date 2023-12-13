extends Node2D

var flashlight: bool = false

func _process(_delta):
	$FlashlightLight.enabled = flashlight
	
	if Input.is_action_just_pressed("primary_action"):
		flashlight = !flashlight
