extends Node2D

var _smoothed_mouse_pos: Vector2
var player: CharacterBody2D
@onready var outer_arm = %OuterArm
@onready var inner_arm = %InnerArm


func _ready():
	player = get_tree().get_first_node_in_group('Player')
	player.change_facing.connect(handle_facing)

func _process(delta):
	_smoothed_mouse_pos = lerp(_smoothed_mouse_pos, get_global_mouse_position(), 0.1)
	$Offset.look_at(_smoothed_mouse_pos)

func handle_facing():
	match(player.facing):
		'right':
			outer_arm.visible = true
			inner_arm.visible = false
			z_index = 1
			#$Offset.position.x = 0
			#$Offset.position.y = 0
		'left':
			outer_arm.visible = false
			inner_arm.visible = true
			z_index = -1
			#$Offset.position.x = 5
			#$Offset.position.y = 1
