extends Control
class_name InputMenu

@onready var input_button = preload("res://UI/Scenes/input_button.tscn")
@onready var action_list: VBoxContainer = $VBoxContainer/Panel/MarginContainer/ScrollContainer/VBoxContainer/ActionList

@onready var settings: Settings = $"../Settings"

var is_remapping := false
var remap_action = null
var remapping_button = null

var input_actions := {
	"left": "Move Left",
	"right": "Move Right",
	"up": "Move Up",
	"down": "Move Down",
	"pause": "Pause",
}

func _ready() -> void:
	create_action_list()

func _process(_delta: float) -> void:
	if Global.paused:
		return
	
	visible = false

func create_action_list():
	InputMap.load_from_project_settings()
	
	for child in action_list.get_children():
		child.queue_free()
	
	for action in input_actions:
		var instance : Button = input_button.instantiate()
		var action_label : Label  = instance.find_child("ActionLabel")
		var input_label : Label  = instance.find_child("InputLabel")
		
		action_label.text = input_actions[action]
		
		var events := InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" - Physical")
		else:
			input_label.text = ""
		
		action_list.add_child(instance)
		
		instance.pressed.connect(_on_input_button_pressed.bind(instance, action))

func _on_input_button_pressed(button: Button, action):
	if is_remapping:
		return
	
	is_remapping = true
	remap_action = action
	remapping_button = button
	button.find_child("InputLabel").text = "Listening for Input"

func _input(event: InputEvent) -> void:
	if !is_remapping:
		return
	
	if event is InputEventKey || (event is InputEventMouseButton && event.pressed):
		InputMap.action_erase_events(remap_action)
		InputMap.action_add_event(remap_action, event)
		_update_action_list(remapping_button, event)
		
		is_remapping = false
		remap_action = null
		remapping_button = null
		
		accept_event()

func _update_action_list(button: Button, event: InputEvent):
	button.find_child("InputLabel").text = event.as_text().trim_suffix(" - Physical")

func _on_return_pressed() -> void:
	settings.visible = true
	visible = false
