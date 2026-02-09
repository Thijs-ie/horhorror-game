extends Node2D
@onready var f_door: Label = $F_Door

func _ready() -> void:
	f_door.visible = false
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed ("interact") and f_door.visible == true:
		Global.main.transition_to_2d("res://2d/Scenes/hallway_floor_2.tscn", "Door_Main")



func _on_door_check_body_entered(body: Node2D) -> void:
	if body as Player2D:
		f_door.visible = true


func _on_door_check_body_exited(body: Node2D) -> void:
	if body as Player2D:
		f_door.visible = false
