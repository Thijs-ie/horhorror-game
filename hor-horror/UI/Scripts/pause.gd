extends Control

@onready var settings: Settings = $"../Settings"

func _process(_delta: float) -> void:
	if !Global.paused:
		visible = true

func _on_resume_pressed() -> void:
	get_parent().visible = false
	Global.pause()

func _on_settings_pressed() -> void:
	visible = false
	settings.visible = true

func _on_quit_1_pressed() -> void:
	Global.pause()
	get_parent().visible = false
	Global.main.transition_to_ui("res://UI/Scenes/main_menu.tscn")

func _on_quit_2_pressed() -> void:
	get_tree().quit()
