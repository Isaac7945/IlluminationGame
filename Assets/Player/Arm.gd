extends Node2D

var _smoothed_mouse_pos: Vector2
var player: CharacterBody2D
var start = false
var follow_mouse = true
@onready var flashlight = $Offset/Flashlight

@onready var outer_arm = %OuterArm
@onready var inner_arm = %InnerArm


func _ready():
	player = get_tree().get_first_node_in_group('Player')
	player.change_facing.connect(handle_facing)
	global.game_over.connect(gameover)
	global.game_start.connect(arm_start)
	global.game_win.connect(gamewin)

func _process(delta):
	_smoothed_mouse_pos = lerp(_smoothed_mouse_pos, get_global_mouse_position(), 0.1)
	
	if flashlight.playing_zap:
		follow_mouse = false
	else:
		follow_mouse = true
	
	if start and follow_mouse:
		$Offset.look_at(_smoothed_mouse_pos)

func arm_start():
	start = true

func gameover():
	start = false

func gamewin():
	outer_arm.visible = false
	inner_arm.visible = false
	gameover()
	
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
