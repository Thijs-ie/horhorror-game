extends Node2D
@onready var f_door: Label = $F_Door

func _process(delta: float) -> void:
	if Input.is_action_just_pressed ("interact") and f_door.visible == true:
		Global.main.transition_to_2d("res://2d/Scenes/test_2d.tscn", "SpawnPoint")
		


func _on_stairs_a_up_body_entered(body: Node2D) -> void:
	if body.name == "Player2D":
		Global.main.transition_to_2d("res://2d/Scenes/halways_floor_3.tscn" , "Stairs_A_down_3")

func _on_stairs_a_down_body_entered(body: Node2D) -> void:
	if body.name == "Player2D":
		Global.main.transition_to_2d("res://2d/Scenes/hallway_floor_1.tscn", "Stairs_A_up_1")

func _on_stairs_b_up_body_entered(body: Node2D) -> void:
	if body.name == "Player2D":
		Global.main.transition_to_2d("res://2d/Scenes/halways_floor_3.tscn", "Stairs_B_down_3")

func _on_stairs_b_down_body_entered(body: Node2D) -> void:
	if body.name == "Player2D":
		Global.main.transition_to_2d("res://2d/Scenes/hallway_floor_1.tscn", "Stairs_B_up_1")


func _on_door_check_body_entered(body: Node2D) -> void:
	if body as Player2D:
		f_door.visible = true

func _on_door_check_body_exited(body: Node2D) -> void:
	if body as Player2D:
		f_door.visible = false
