extends CharacterBody2D


@export var spd: int
@export var jump_velocity: int
@export var gravity: int


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * spd
	else:
		velocity.x = move_toward(velocity.x, 0, spd)

	move_and_slide()
