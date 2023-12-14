extends Node2D

@onready var grass_sprite = $GrassSprite


func _ready():
	grass_sprite.frame = randi_range(1, 9)
