extends CharacterBody2D

@onready var enemy_sprite = $EnemySprite


func _physics_process(_delta):
	move_and_slide()
	
