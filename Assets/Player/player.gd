extends CharacterBody2D

signal change_facing
var facing: String = 'right':
	set(value):
		facing = value
		change_facing.emit()
var gravity = 400
@onready var anim = $AnimatedSprite2D
@onready var arm = $"Outer Arm"

func _process(delta):
	if get_global_mouse_position().x > position.x:
		if facing != 'right':
			facing = 'right'
			scale.x = scale.y
	else:
		if facing != 'left':
			facing = 'left'
			scale.x = -scale.y
	#print($"State Machine".current_state.name.to_lower())


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
