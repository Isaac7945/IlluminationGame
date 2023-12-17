extends Node2D

var bat_max = global.battery_max
var bat_min = global.battery_min
@export var charge_time: float = 1
@export var regen_amount: float = 0.05
@export var zapper_drain: float = (bat_max / 3) + bat_min
@export var flashlight_drain: float = 0.05
var regen = false

@onready var regen_timer = $RegenTimer
@onready var zap_charge_timer = $ZapChargeTimer
@onready var flashlight_hitbox = $FlashlightArea/FlashlightHitbox

var flashlight: bool = false:
	set(value):
		flashlight = value
		
		ui.battery_ui_switch(value) # Turn on and off Battery ui
		if !value: # Start regen timer if light turned off
			regen_timer.start()

@onready var spr = $Sprite2D


func _process(_delta):
	$FlashlightLight.enabled = flashlight
	
	if Input.is_action_just_pressed("primary_action"):
		flashlight = !flashlight
		
		if regen: # Stop regen on flashlight on/off
			regen = false
			
		flashlight_hitbox.disabled = !flashlight # Hitbox
	
	#if regen:
		#flashlight = false
	
	# Drain flashlight
	if flashlight:
		global.battery -= flashlight_drain
		spr.frame = 1
		
		# Turn flashlight off when no battery
		if global.battery <= bat_min:
			global.battery = bat_min
			flashlight = false
	else:
		spr.frame = 0
		
		if regen and global.battery < bat_max:
			global.battery += regen_amount
		


func _on_regen_timer_timeout():
	regen = true


func _on_flashlight_area_body_entered(body):
	if 'flashed' in body:
		body.flashed()
