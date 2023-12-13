extends State
class_name PlayerWalk

@export var spd: int
@export var anim: AnimationPlayer
@export var player: CharacterBody2D

func enter():
	if player: # Connect signal from player, emits when changing direction
		player.change_facing.connect(change_facing)
		change_facing()

# Handle animation matching left or right, or going backwards
func change_facing():
	var dir = Input.get_axis("move_left", "move_right")
	match(player.facing):
		'right':
			if dir > 0:
				anim.play('walk_right')
			elif dir < 0:
				anim.play_backwards('walk_right') # Play anim backwards if going backwards
		'left':
			if dir < 0:
				anim.play('walk_left')
			elif dir > 0:
				anim.play_backwards('walk_left')

func physics_process(delta):
	# Handle movement
	var dir = Input.get_axis("move_left", "move_right")
	if dir:
		player.velocity.x = dir * spd
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, spd)
		
	player.move_and_slide()
	
	# Transition to idle
	if dir == 0 and player.velocity.x == 0:
		Transitioned.emit(self, 'idle')

func exit():
	player.change_facing.disconnect(change_facing)
	anim.stop()
