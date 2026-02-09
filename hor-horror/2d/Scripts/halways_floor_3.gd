extends Node2D
@onready var f_door: Label = $F_Door
@onready var f_door_2: Label = $F_Door2

func _process(delta: float) -> void:
	if Input.is_action_just_pressed ("interact") and f_door.visible == true:
		Global.main.transition_to_2d("res://2d/Scenes/room_19&20.tscn", "Room_19")
		
	if Input.is_action_just_pressed ("interact") and f_door_2.visible == true:
		Global.main.transition_to_2d("res://2d/Scenes/room_19&20.tscn", "Room_20")


func _on_stairs_a_up_body_entered(body: Node2D) -> void:
	if body as Player2D:
		Global.main.transition_to_2d("res://2d/Scenes/hallway_floor_2.tscn", "Stairs_A_up_2")


func _on_stairs_b_up_body_entered(body: Node2D) -> void:
	if body as Player2D:
		Global.main.transition_to_2d("res://2d/Scenes/hallway_floor_2.tscn", "Stairs_B_up_2")


func _on_door_check_19_body_entered(body: Node2D) -> void:
	if body as Player2D:
		f_door.visible = true


func _on_door_check_19_body_exited(body: Node2D) -> void:
	if body as Player2D:
		f_door.visible = false

func _on_door_check_20_body_entered(body: Node2D) -> void:
	if body as Player2D:
		f_door_2.visible = true
	
	
func _on_door_check_20_body_exited(body: Node2D) -> void:
	if body as Player2D:
		f_door_2.visible = false
