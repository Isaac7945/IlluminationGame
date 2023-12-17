extends State
class_name EnemyFlashed

@export var enemy: CharacterBody2D
@export var spr: AnimatedSprite2D
@onready var flashed_timer = $FlashedTimer
var flashed_tween
@export_color_no_alpha var flashed_color

func enter():
	enemy.Flashed.emit()
	flashed_timer.start()
	
	flashed_tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR)
	flashed_tween.tween_property(spr, 'modulate', flashed_color, 0.2)
	

func _on_flashed_timer_timeout():
	Transitioned.emit(self, 'follow')

