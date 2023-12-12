extends State
class_name PlayerIdle

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func enter():
	anim.animation = "idle_right"

func process(delta):
	pass
