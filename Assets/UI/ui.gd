extends CanvasLayer

var bat_max = global.battery_max
var bat_min = global.battery_min
@onready var battery_bar: TextureProgressBar = %BatteryProgressBar
@export_color_no_alpha var progress_bar_off # Gray color for off

# Battery alphas for on/off
var battery_on_alpha = Color(1, 1, 1, 1)
var battery_off_alpha = Color(1, 1, 1, 0.2)

# Battery progress sprites
var high_battery_spr = preload("res://Assets/Sprites/UI/statusgreen.png")
var mid_battery_spr = preload("res://Assets/Sprites/UI/statusdarkgreen.png")
var low_battery_spr = preload("res://Assets/Sprites/UI/statusdarkestgreen.png")

func _ready():
	battery_bar.visible = false
	global.game_start.connect(enable_ui) # connect signal from global
	battery_ui_switch(false) # Battery off by default

func _process(_delta):
	battery_bar.value = global.battery # Progress bar is equal to battery left
	
	# Change progress sprite when low
	if global.battery < (bat_max / 4) + bat_min:
		battery_bar.texture_progress = low_battery_spr
	elif global.battery < (bat_max / 2) + bat_min:
		battery_bar.texture_progress = mid_battery_spr		
	else:
		battery_bar.texture_progress = high_battery_spr		
		
	
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
