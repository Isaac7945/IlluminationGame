extends CanvasLayer

@onready var grayscale = $ColorRect

func _ready():
	grayscale.mouse_filter = 2
