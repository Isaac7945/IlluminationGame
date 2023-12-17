extends Node2D

@onready var grass_spawners = $GrassSpawners
@onready var enemy_path = %EnemyPath
@onready var player = $Player

#var enemy_scene = preload("res://Assets/Enemy/enemy.tscn")
var enemy_follow_scene = preload("res://Assets/Enemy/enemy_path_follow.tscn")


func _ready():
	global.game_start.emit()
	
	var grass: Array = grass_spawners.get_children()
	#for new_grass in grass_spawners.get_child_count():
		#grass.pop_front()

func _process(_delta):
	enemy_path.position = player.position
	
	
func spawn_enemy():
	var new_enemy_follow = enemy_follow_scene.instantiate()
	new_enemy_follow.rotates = false
	enemy_path.add_child(new_enemy_follow)


func _on_enemy_spawn_timer_timeout():
	var spawn_check = randi() % 100
	if spawn_check < global.spawn_rate:
		spawn_enemy()
	$EnemySpawnTimer.start()
