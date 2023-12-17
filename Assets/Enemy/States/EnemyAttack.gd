extends State
class_name EnemyAttack

@export var enemy: CharacterBody2D
@export var anim: AnimationPlayer
@export var proj: PackedScene
@export var attack_endlag: float = 1
@export var endlag_timer: Timer
var projectiles: Node2D
var player
var attack_tween

func enter():
	player = get_tree().get_first_node_in_group('Player')
	if enemy.house_enemy:
		player = get_tree().get_first_node_in_group('House')
	
	projectiles = get_tree().get_first_node_in_group('Projectiles')
	anim.play('attack')
	
	projectile()

func projectile():
	var player_offset = 0
	if player is CharacterBody2D:
		if player.velocity.x > 0:
			player_offset = 25
		elif player.velocity.x < 0:
			player_offset = -25
		
	var new_fireball = proj.instantiate()
	new_fireball.position = enemy.global_position
	new_fireball.direction = (Vector2(player.global_position.x + player_offset, player.global_position.y) - enemy.global_position).normalized()
	projectiles.add_child(new_fireball)
	
	endlag_timer.wait_time = attack_endlag
	endlag_timer.start()


func _on_end_lag_timer_timeout():
	if !enemy.house_enemy:
		Transitioned.emit(self, 'follow')
	else:
		Transitioned.emit(self, 'idle')
