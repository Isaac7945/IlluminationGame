extends State
class_name EnemyDeath

@export var anim: AnimationPlayer
@export var enemy: CharacterBody2D
@export var deathsound: AudioStreamPlayer2D

func enter():
	print('death')
	deathsound.play()
	anim.play('death')
	await anim.animation_finished
	enemy.Died.emit()
	queue_free()
