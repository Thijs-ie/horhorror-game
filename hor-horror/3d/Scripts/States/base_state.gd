extends Node
class_name State

@export var player: Player3D

@warning_ignore("unused_signal")
signal state_transition

func enter_state():
	pass
func exit_state():
	pass
func update(_delta):
	pass
func physics_update(_delta):
	pass
