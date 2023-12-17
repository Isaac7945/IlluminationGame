extends Area2D

var direction: Vector2
var player: CharacterBody2D
@export var spd: float = 100

func _ready():
	player = get_tree().get_first_node_in_group('Player')
	rotation_degrees = rad_to_deg(direction.angle()) - 90

func _process(delta):
	position += direction * spd * delta


func _on_body_entered(body):
	if body == player:
		body.hit()
		queue_free()
