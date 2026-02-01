extends Node
class_name FiniteStateMachine

var states : Dictionary = {}
var current_state : State
@export var initial_state : State

func _ready() -> void:
	for child in get_children():
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)
	if initial_state:
		initial_state.enter_state()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func change_state(_source_state: State, new_state_name: String):
	var new_state = states.get(new_state_name.to_lower())
	
	if !new_state:
		print("New state is empty")
		return
	
	if current_state:
		current_state.exit_state()
	
	new_state.enter_state()
	current_state = new_state
