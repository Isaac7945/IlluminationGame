extends CharacterBody2D

@onready var enemy_sprite = $EnemySprite


func _physics_process(_delta):
	move_and_slide()
	
	if velocity.x > 0:
		enemy_sprite.flip_h = false
	elif velocity.x < 0:
		enemy_sprite.flip_h = true
