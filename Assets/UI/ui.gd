extends CanvasLayer

var bat_max = global.battery_max
var bat_min = global.battery_min
@onready var battery_bar: TextureProgressBar = %BatteryProgressBar
@onready var charge_progress_bar = $ChargeContainer/ChargeProgressBar
@onready var heart_container = $HeartContainer
@onready var heart_1 = %Heart1
@onready var heart_2 = %Heart2
@onready var heart_3 = %Heart3
var charging = false:
	set(value):
		charging = value
		charge_progress_bar.visible = value

@export_color_no_alpha var progress_bar_off # Gray color for off

# Battery alphas for on/off
var battery_on_alpha = Color(1, 1, 1, 1)
var battery_off_alpha = Color(1, 1, 1, 0.2)

var hearts_on_alpha = Color(1, 1, 1, 1)
var hearts_off_alpha = Color(1, 1, 1, 0)

# Battery progress sprites
var high_battery_spr = preload("res://Assets/Sprites/UI/statusgreen.png")
var mid_battery_spr = preload("res://Assets/Sprites/UI/statusdarkgreen.png")
var low_battery_spr = preload("res://Assets/Sprites/UI/statusdarkestgreen.png")

func _ready():
	heart_container.modulate = hearts_off_alpha
	battery_bar.visible = false
	charge_progress_bar.visible = false
	
	global.game_start.connect(enable_ui) # connect signal from global
	global.game_over.connect(gameover)
	battery_ui_switch(false) # Battery off by default

func _process(_delta):
	battery_bar.value = global.battery # Progress bar is equal to battery left
	charge_progress_bar.value = global.zap_charge
	
	# Change progress sprite when low
	if global.battery < (bat_max / 4) + bat_min:
		battery_bar.texture_progress = low_battery_spr
	elif global.battery < (bat_max / 2) + bat_min:
		battery_bar.texture_progress = mid_battery_spr		
	else:
		battery_bar.texture_progress = high_battery_spr		
		
	
func player_hit():
	heart_container.modulate = hearts_on_alpha
	
	match(global.hp):
		3:
			pass
		2:
			heart_3.visible = false
		1:
			heart_2.visible = false
		0:
			heart_1.visible = false
			global.game_over.emit()
			
	await get_tree().create_timer(1).timeout
	
	var heart_tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR)
	heart_tween.tween_property(heart_container, 'modulate', hearts_off_alpha, 1)
	
		
# Called from flashlight
func battery_ui_switch(flashlight):
	if flashlight:
		battery_bar.modulate = battery_on_alpha
		battery_bar.tint_progress = Color(1, 1, 1)
	else:
		battery_bar.modulate = battery_off_alpha
		battery_bar.tint_progress = progress_bar_off

func enable_ui():
	battery_bar.visible = true
	
func gameover():
	battery_bar.visible = false
	charge_progress_bar.visible = false
	heart_container.visible = false
