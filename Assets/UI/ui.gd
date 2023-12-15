extends CanvasLayer

@onready var battery_bar: TextureProgressBar = %BatteryProgressBar

func _ready():
	battery_bar.visible = false
	global.game_start.connect(enable_ui)

func _process(_delta):
	battery_bar.value = global.battery

func enable_ui():
	battery_bar.visible = true
