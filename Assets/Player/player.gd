extends CharacterBody2D

signal change_facing
var facing: String = 'right':
	set(value):
		facing = value
		change_facing.emit()
var gravity = 400
@onready var anim = $AnimatedSprite2D
@onready var arm = $Arm
@onready var state_machine = $"State Machine"
var slow = false

func _process(delta):
	if get_global_mouse_position().x > position.x:
		if facing != 'right':
			facing = 'right'
			scale.x = scale.y
	else:
		if facing != 'left':
			facing = 'left'
			scale.x = -scale.y

func hit():
	print('hit player')

func walk():
	state_machine.on_child_transition(state_machine.current_state, 'walk')

func idle():
	state_machine.on_child_transition(state_machine.current_state, 'idle')


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
