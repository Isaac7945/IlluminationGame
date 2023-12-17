extends Node2D

var bat_max = global.battery_max
var bat_min = global.battery_min
@export var charge_time: float = 1
@export var regen_amount: float = 0.05
@export var zapper_drain: float = (bat_max / 3) + bat_min
@export var flashlight_drain: float = 0.05
var regen = false
var zap_charging = false
var zapping = false
var zap_charged = false
var player: CharacterBody2D

@onready var regen_timer = $RegenTimer
@onready var zap_charge_timer = $ZapChargeTimer
@onready var flashlight_hitbox = $FlashlightArea/FlashlightHitbox
@onready var anim = $FlashlightAnimation


var flashlight: bool = false:
	set(value):
		flashlight = value
		
		ui.battery_ui_switch(value) # Turn on and off Battery ui
		if !value: # Start regen timer if light turned off
			regen_timer.start()

@onready var spr = $Sprite2D

func _ready():
	player = get_tree().get_first_node_in_group('Player')

func _process(_delta):
	$FlashlightLight.enabled = flashlight
	
	if Input.is_action_just_pressed("secondary_action") and !zapping:
		zap_charging = true
		zap_charge_timer.start()
		player.idle() # Make player stop
		
		if flashlight:
			toggle_flashlight()
			
		zapping = true

	if zap_charging:
		if Input.is_action_just_released("secondary_action"):
			zapping = false
			zap_charge_timer.stop()
			zap_charging = false
			player.walk()  # Resume walking
	
	if zap_charged:
		if Input.is_action_just_released("secondary_action"):
			zap()
	
	if Input.is_action_just_pressed("primary_action") and !zapping:
		toggle_flashlight()
	
	# Drain flashlight
	if flashlight:
		global.battery -= flashlight_drain
		spr.frame = 1
		player.slow = true
		
		
		# Turn flashlight off when no battery
		if global.battery <= bat_min:
			global.battery = bat_min
			flashlight = false
	else:
		spr.frame = 0
		player.slow = false
		
		if regen and global.battery < bat_max:
			global.battery += regen_amount
		

func zap():
	zap_charged = false
	anim.play('zap')
	await anim.animation_finished
	zapping = false
	player.walk() # Resume walking
	
func toggle_flashlight():
	flashlight = !flashlight
	
	if regen: # Stop regen on flashlight on/off
		regen = false
		
	flashlight_hitbox.disabled = !flashlight # Hitbox

func _on_regen_timer_timeout():
	regen = true


func _on_flashlight_area_body_entered(body):
	if 'flashed' in body:
		body.flashed()
		

func _on_flashlight_area_body_exited(body):
	if 'flash_over' in body:
		body.flash_over()


func _on_zap_area_body_entered(body):
	print(body)	
	if 'zapped' in body:
		body.zapped()


func _on_zap_charge_timer_timeout():
	zap_charged = true
	zap_charging = false	
