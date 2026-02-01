extends Control
class_name MainMenu

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_scene_2d_pressed() -> void:
	Global.main.transition_to_2d("res://2d/Scenes/test_2d.tscn")


func _on_scene_3d_pressed() -> void:
	Global.main.transition_to_3d("res://3d/Scenes/test_3d.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
