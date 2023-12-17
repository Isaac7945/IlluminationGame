extends CharacterBody2D

@onready var enemy_sprite = $EnemySprite
@onready var state_machine = $"State Machine"
@onready var flashed_timer = $"State Machine/Flashed/FlashedTimer"
var path_ratio: float
var house_enemy = false
signal PathMove
signal Flashed
signal PathMoveFinished
signal Died

func _physics_process(_delta):
	move_and_slide()

func flashed():
	state_machine.on_child_transition(state_machine.current_state, 'flashed')

func flash_over():
	flashed_timer.start()

func zapped():
	state_machine.on_child_transition(state_machine.current_state, 'death')


func path_move_finished():
	PathMoveFinished.emit()
