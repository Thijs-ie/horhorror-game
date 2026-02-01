extends State
class_name IdleState

func physics_update(_delta : float):
	if player.input_dir:
		state_transition.emit(self, "MoveState")
