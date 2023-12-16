extends Node2D

@onready var grass_spawners = $GrassSpawners
@onready var enemy_path = %EnemyPath
@onready var player = $Player

var enemy_scene = preload("res://Assets/Enemy/enemy.tscn")


func _ready():
	global.game_start.emit()
	
	var grass: Array = grass_spawners.get_children()
	#for new_grass in grass_spawners.get_child_count():
		#grass.pop_front()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()

func _process(_delta):
	enemy_path.position = player.position
	
func spawn_enemy():
	var path_follow_node = PathFollow2D.new()
	var new_enemy = enemy_scene.instantiate()
	path_follow_node.progress_ratio = randf_range(0, 1)
	path_follow_node.add_child(new_enemy)
	enemy_path.add_child(path_follow_node)
