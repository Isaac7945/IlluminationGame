class_name State
extends Node

# This class will be passed into all states, giving each of them these functions and signals

# Will be called when going from one state to another
signal Transitioned

func enter(): # Enter State
	pass

func exit(): # Leave State
	pass

func process(_delta: float): # Run code every frame while in this state
	pass

func physics_process(_delta: float): # Physics running every frame while in this state
	pass
