extends Node
class_name Main

@onready var world_2d: Node2D = $World2D
@onready var world_3d: Node3D = $World3D
@onready var ui: CanvasLayer = $UI

@onready var transition: Control = $UI/Transition
var anim_player : AnimationPlayer

var transition_in := "transition_in"
var transition_out := "transition_out"

var custom_blend := -1

var player_2d := preload("res://2d/Scenes/player_2d.tscn")

func _ready() -> void:
	Global.main = self
	
	for child in transition.get_children():
		if child as AnimationPlayer:
			anim_player = child

func transition_to_2d(target_scene : String, spawn_point : String, seconds : float = 1.0):
	anim_player.play(transition_out, custom_blend, 1.0 / seconds)
	
	await anim_player.animation_finished
	
	for child in world_2d.get_children():
		world_2d.remove_child(child)
	for child in world_3d.get_children():
		world_3d.remove_child(child)
	for child in ui.get_children():
		if child.name != "Transition":
			ui.remove_child(child)
	
	var scene := load(target_scene)
	var scene_instance = scene.instantiate()
	
	var player_instance = player_2d.instantiate()
	var coordinates = scene_instance.find_child(spawn_point)
	player_instance.global_position = coordinates.global_position
	scene_instance.add_child(player_instance)
	
	
	world_2d.add_child(scene_instance)
	
	anim_player.play(transition_in, custom_blend, 1.0 / seconds)

func transition_to_3d(target_scene : String, seconds : float = 1.0):
	anim_player.play(transition_out, custom_blend, 1.0 / seconds)
	
	await anim_player.animation_finished
	
	for child in world_2d.get_children():
		world_2d.remove_child(child)
	for child in world_3d.get_children():
		world_3d.remove_child(child)
	for child in ui.get_children():
		if child.name != "Transition":
			ui.remove_child(child)
	
	var scene = load(target_scene)
	var instance = scene.instantiate()
	
	world_3d.add_child(instance)
	
	anim_player.play(transition_in, custom_blend, 1.0 / seconds)

func transition_to_ui(target_scene : String, seconds : float = 1.0):
	anim_player.play(transition_out, custom_blend, 1.0 / seconds)
	
	await anim_player.animation_finished
	
	for child in world_2d.get_children():
		world_2d.remove_child(child)
	for child in world_3d.get_children():
		world_3d.remove_child(child)
	for child in ui.get_children():
		if child.name != "Transition":
			ui.remove_child(child)
	
	var scene = load(target_scene)
	var instance = scene.instantiate()
	
	ui.add_child(instance)
	
	anim_player.play(transition_in, custom_blend, 1.0 / seconds)
