extends PathFollow2D

var enemy = preload("res://Assets/Enemy/enemy.tscn")
var my_enemy: CharacterBody2D
var player: CharacterBody2D
var arm_side: String
var enemy_spawned = false
var tween_move
var enemy_closer_spd = 0.1

func _ready():
	progress_ratio = randf()
	player = get_tree().get_first_node_in_group('Player')
	rotates = false

func _process(_delta):
	if my_enemy:
		my_enemy.path_ratio = progress_ratio
	
	arm_side = 'left' if get_global_mouse_position().x < player.position.x else 'right'
	
	# Make sure enemy spawns on opposite sides
	if !enemy_spawned:
		if progress_ratio > 0.5 and arm_side != 'right':
			spawnEnemy()
		elif progress_ratio < 0.5 and arm_side != 'left':
			spawnEnemy()


func spawnEnemy():
	var new_enemy = enemy.instantiate()
	new_enemy.connect('PathMove', moveEnemy)
	new_enemy.connect('Flashed', enemy_flashed)
	new_enemy.connect('Died', enemyDied)
	my_enemy = new_enemy
	add_child(new_enemy)
	
	enemy_spawned = true
	
func enemy_flashed():
	if tween_move:
		tween_move.kill()

func moveEnemy():
	tween_move = get_tree().create_tween()
	
	var move_range
	if progress_ratio < 0.3:
		move_range = randf_range(0, 0.25)
	elif progress_ratio > 0.7:
		move_range = randf_range(-0.25, 0)
	else:
		move_range = randf_range(-0.25, 0.25)
	var new_progress = progress_ratio + move_range 

	tween_move.tween_property(self, "progress_ratio", new_progress, 1).set_trans(Tween.TRANS_SINE)
	await tween_move.finished
	my_enemy.path_move_finished()
	
func enemyDied():
	queue_free()

