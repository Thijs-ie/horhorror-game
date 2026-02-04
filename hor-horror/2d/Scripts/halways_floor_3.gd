extends Node2D

func _on_stairs_a_up_body_entered(body: Node2D) -> void:
	if body.name == "Player2D":
		Global.main.transition_to_2d("res://2d/Scenes/hallway_floor_2.tscn", "Stairs_A_up_2")


func _on_stairs_b_up_body_entered(body: Node2D) -> void:
	if body.name == "Player2D":
		Global.main.transition_to_2d("res://2d/Scenes/hallway_floor_2.tscn", "Stairs_B_up_2")
