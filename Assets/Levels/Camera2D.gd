extends Camera2D

var house
@export var player: CharacterBody2D

func _ready():
	house = get_tree().get_first_node_in_group('House')
	await get_tree().create_timer(1).timeout
	
	var to_house_tween = get_tree().create_tween().set_trans(Tween.TRANS_CIRC)
	to_house_tween.tween_property(self, 'global_position', house.global_position, 1)
	await to_house_tween.finished
	
	await get_tree().create_timer(2).timeout
	
	var to_player_tween = get_tree().create_tween().set_trans(Tween.TRANS_CIRC)
	to_player_tween.tween_property(self, 'global_position', player.global_position, 1)
	await to_player_tween.finished
	await get_tree().create_timer(1).timeout

	global.game_start.emit()

