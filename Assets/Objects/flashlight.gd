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
var start = false
@export var playing_zap = false
var charging_tween

@onready var regen_timer = $RegenTimer
@onready var zap_charge_timer = $ZapChargeTimer
@onready var flashlight_hitbox = $FlashlightArea/FlashlightHitbox
@onready var anim = $FlashlightAnimation
@onready var sprite_2d = $Sprite2D


@onready var on_audio = $OnAudio
@onready var off_audio = $OffAudio
@onready var zap_audio = $ZapAudio
@onready var charge_audio = $ChargeAudio



var flashlight: bool = false:
	set(value):
		flashlight = value
		
		ui.battery_ui_switch(value) # Turn on and off Battery ui
		if !value: # Start regen timer if light turned off
			regen_timer.start()
		
		if value:
			on_audio.play()
		else:
			off_audio.play()

@onready var spr = $Sprite2D

func _ready():
	player = get_tree().get_first_node_in_group('Player')
	global.game_start.connect(flashlight_start)
	global.game_over.connect(gameover)
	global.game_win.connect(gamewin)

func _process(_delta):
	$FlashlightLight.enabled = flashlight
	
	if start:
		if Input.is_action_just_pressed("secondary_action") and !zapping:
			zap_charging = true
			zap_charge_timer.start()
			player.idle() # Make player stop
			charge_audio.play()
			ui.charging = true
			charging_tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR)
			charging_tween.tween_property(global, 'zap_charge', 100, charge_time)
			
			if flashlight:
				toggle_flashlight()
				
			if regen: # Stop regen
				regen = false
				
			zapping = true
			
		if zap_charging:
			if Input.is_action_just_released("secondary_action"):
				zapping = false
				zap_charge_timer.stop()
				zap_charging = false
				charge_audio.stop()
				if charging_tween:
					charging_tween.stop()
				global.zap_charge = 0
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
		
		
func flashlight_start():
	start = true
	
func gamewin():
	sprite_2d.visible = false
	flashlight = false
	gameover()
	
func gameover():
	start = false

func zap():
	zap_charged = false
	global.battery -= (global.battery_max - global.battery_min) / 3
	global.zap_charge = 0
	zap_audio.play()
	anim.play('zap')
	
	await anim.animation_finished
	zapping = false
	player.walk() # Resume walking
	regen_timer.start()
	
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
