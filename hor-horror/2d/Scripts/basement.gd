extends Node2D
@onready var basement: Marker2D = $basement
@onready var f_door: Label = $F_Door


func _process(delta: float) -> void:
	if Input.is_action_just_pressed ("interact") and f_door.visible == true:
		Global.main.transition_to_2d("res://2d/Scenes/hallway_floor_1.tscn", "Stairs2")


func _on_stairs_body_entered(body: Node2D) -> void:
	if body as Player2D:
		f_door.visible = true


func _on_stairs_body_exited(body: Node2D) -> void:
	if body as Player2D:
		f_door.visible = false
