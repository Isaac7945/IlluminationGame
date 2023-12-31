extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var spr: AnimatedSprite2D
@export var moveTimer: Timer
@export var attack_percentage: int = 40
@export var anim: AnimationPlayer
var player: CharacterBody2D
signal PathMove


func enter():
	player = get_tree().get_first_node_in_group('Player') 
	enemy.PathMoveFinished.connect(move_finished)
	moveTimer.start()
	anim.play('idle')
	
func process(delta):
	# Flip sprite and look at player
	enemy.scale.x = enemy.scale.y if enemy.path_ratio < 0.5 else -enemy.scale.y
	#enemy.look_at(player.position)
	pass
	
	
func _on_move_timer_timeout():
	enemy.PathMove.emit()
	
	moveTimer.wait_time = randf_range(1, 3)
	moveTimer.start()

func move_finished():
	var rollforattack = randi() % 100
	if rollforattack < attack_percentage:
		Transitioned.emit(self, 'attack')

func exit():
	moveTimer.stop()
	enemy.PathMoveFinished.disconnect(move_finished)
