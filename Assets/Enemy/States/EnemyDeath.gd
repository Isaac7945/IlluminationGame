extends State
class_name EnemyDeath

@export var anim: AnimationPlayer
@export var enemy: CharacterBody2D

func enter():
	print('death')
	anim.play('death')
	await anim.animation_finished
	enemy.Died.emit()
	queue_free()
