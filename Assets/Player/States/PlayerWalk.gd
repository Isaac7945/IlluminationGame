extends State
class_name PlayerWalk

@export var anim: AnimationPlayer
@export var player: CharacterBody2D
@export var spd: float = 60
@export var grass_audio: AudioStreamPlayer2D
@export var slow_audio: AudioStreamPlayer2D
var anim_spd: float

func enter():
	grass_audio.play()
	
	if player: # Connect signal from player, emits when changing direction
		player.change_facing.connect(change_facing)
		player.slow_changed.connect(slow_change)
		change_facing()

# Handle animation matching left or right, or going backwards
func change_facing():
	anim.stop()
	var dir = 1
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
	if player.slow:
		spd = 30
		anim_spd = 0.5
	else:
		spd = 60
		anim_spd = 0.7
		
		
	anim.speed_scale = anim_spd
	
	var dir = 1
	if dir:
		player.velocity.x = dir * spd
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, spd)
		
	player.move_and_slide()
	
	# Transition to idle
	#if dir == 0 and player.velocity.x == 0:
		#Transitioned.emit(self, 'idle')

func slow_change():
	if player.slow:
		slow_audio.stop()
		grass_audio.play()
	else:
		grass_audio.stop()
		slow_audio.play()
		

func exit():
	slow_audio.stop()
	grass_audio.stop()
	player.change_facing.disconnect(change_facing)
	player.slow_changed.disconnect(slow_change)
	anim.stop()
