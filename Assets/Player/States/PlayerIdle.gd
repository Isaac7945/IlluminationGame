extends State
class_name PlayerIdle

@export var anim: AnimationPlayer
@export var player: CharacterBody2D

func enter():
	global.connect('can_move', init_walking)
	if player: # Connect signal from player, emits when changing direction
		player.change_facing.connect(change_facing)
		change_facing()

func change_facing():
	match(player.facing):
		'right':
			anim.set_current_animation('idle_right')
		'left':
			anim.set_current_animation('idle_left')
	anim.play()

func process(delta):
	#var dir = Input.get_axis("move_left", "move_right")
	#if dir != 0:
		#Transitioned.emit(self, 'walk')
	pass

func init_walking():
	Transitioned.emit(self, 'walk')

func exit():
	player.change_facing.disconnect(change_facing)
	anim.stop()
