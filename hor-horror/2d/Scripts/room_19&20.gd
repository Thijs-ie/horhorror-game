extends Node2D
@onready var f_door: Label = $F_Door
@onready var f_door_2: Label = $F_Door2

func _process(delta: float) -> void:
	if Input.is_action_just_pressed ("interact") and f_door.visible == true:
		Global.main.transition_to_2d("res://2d/Scenes/halways_floor_3.tscn", "Door_19")
		
	if Input.is_action_just_pressed ("interact") and f_door_2.visible == true:
		Global.main.transition_to_2d("res://2d/Scenes/halways_floor_3.tscn", "Door_20")
		

func _on_door_check_body_entered(body: Node2D) -> void:
	if body as Player2D:
		f_door.visible = true


func _on_door_check_2_body_entered(body: Node2D) -> void:
	if body as Player2D:
		f_door_2.visible = true


func _on_door_check_body_exited(body: Node2D) -> void:
	if body as Player2D:
		f_door.visible = false


func _on_door_check_2_body_exited(body: Node2D) -> void:
	if body as Player2D:
		f_door_2.visible = false
