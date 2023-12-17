extends State
class_name EnemyFlashed

@export var enemy: CharacterBody2D
@onready var flashed_timer = $FlashedTimer

func enter():
	enemy.Flashed.emit()
	flashed_timer.start()


func _on_flashed_timer_timeout():
	Transitioned.emit(self, 'follow')
