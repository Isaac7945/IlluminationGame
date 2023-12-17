extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var spr: AnimatedSprite2D
@export var move_spd := 50.0
@export var detect_range = 50
@export var anim: AnimationPlayer
var player: CharacterBody2D
var max_height: int
var min_height: int
var move_y: float

var move_direction: Vector2
var wander_time: float

func _ready():
	player = get_tree().get_first_node_in_group('Player')
	min_height = player.position.y - 50
	max_height = player.position.y + 10
	
	anim.play('idle')

func randomize_wander():
	if enemy.position.y < min_height:
		move_y = 1
	elif enemy.position.y > max_height:
		move_y = -1
	else:
		move_y = randf_range(-1, 1)
		
	move_direction = Vector2(randf_range(-1, 1), move_y).normalized()
	wander_time = randf_range(1, 3)

func enter():
	randomize_wander()

func process(delta):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
		
	# Flip sprite to movement
	if enemy.velocity.x > 0:
		spr.flip_h = false
	elif enemy.velocity.x < 0:
		spr.flip_h = true
	
	# Detect if player nearby, start following
	if enemy.position.distance_to(player.position) < detect_range:
		Transitioned.emit(self, 'follow')

func physics_process(delta):
	if enemy: # Move Enemy
		enemy.velocity = move_direction * move_spd

