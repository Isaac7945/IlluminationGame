extends Node2D

@onready var grass_spawners = $GrassSpawners


func _ready():
	var grass: Array = grass_spawners.get_children()
	#for new_grass in grass_spawners.get_child_count():
		#grass.pop_front()
