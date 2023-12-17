extends State
class_name EnemyAttack

@export var enemy: CharacterBody2D
@export var anim: AnimationPlayer
@export var proj: PackedScene
@export var attack_endlag: float = 1
@export var endlag_timer: Timer
var projectiles: Node2D
var player: CharacterBody2D
var attack_tween

func enter():
	player = get_tree().get_first_node_in_group('Player')
	projectiles = get_tree().get_first_node_in_group('Projectiles')
	anim.play('attack')
	
	projectile()

func projectile():
	var new_fireball = proj.instantiate()
	new_fireball.position = enemy.global_position
	new_fireball.direction = (player.global_position - enemy.global_position).normalized()
	projectiles.add_child(new_fireball)
	
	endlag_timer.wait_time = attack_endlag
	endlag_timer.start()


func _on_end_lag_timer_timeout():
	Transitioned.emit(self, 'follow')
