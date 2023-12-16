extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var spr: AnimatedSprite2D
var player: CharacterBody2D
var path: PathFollow2D


func enter():
	player = get_tree().get_first_node_in_group('Player') 
	
func process(delta):
	# Flip sprite and look at player
	spr.flip_v = true if enemy.position > player.position else false
	enemy.look_at(player.position)
		
