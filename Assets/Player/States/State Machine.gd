extends Node

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	
	if initial_state: # If initial_state exists, enter that state at ready()
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_process(delta)

func on_child_transition(state, new_state_name):
	if state != current_state: # Leave on_child_transition if the originally called state doesnt match the current one 
		return
	
	# Get the new state from the dictionary (points to a node)
	var new_state = states.get(new_state_name.to_lower())
	if !new_state: # Makes sure that new state (a node), exists, if not then get out
		return
	
	# Leave current state
	if current_state:
		current_state.exit()
	
	# Enter new state
	new_state.enter()
	
	# Set current state to the new one
	current_state = new_state
