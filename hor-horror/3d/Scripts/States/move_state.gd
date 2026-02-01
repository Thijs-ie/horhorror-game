extends State
class_name MoveState

func enter_state():
	player.speed = 5.0

func physics_update(_delta : float):
	if !player.input_dir:
		state_transition.emit(self, "IdleState")
