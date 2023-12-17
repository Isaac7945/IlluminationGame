extends CharacterBody2D

@onready var enemy_sprite = $EnemySprite
@onready var state_machine = $"State Machine"
var path_ratio: float
signal PathMove
signal Flashed
signal PathMoveFinished

func _physics_process(_delta):
	move_and_slide()

func flashed():
	state_machine.on_child_transition(state_machine.current_state, 'flashed')

func path_move_finished():
	PathMoveFinished.emit()
