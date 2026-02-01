extends Control
class_name Settings

@onready var fov: Label = $HBoxContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/VBoxContainer/FieldOfView/HBoxContainer/FOV
@onready var fov_slider: HSlider = $HBoxContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/VBoxContainer/FieldOfView/HBoxContainer/FOVSlider
@onready var fps: Label = $HBoxContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/VBoxContainer/MaxFPS/HBoxContainer/FPS
@onready var fps_slider: HSlider = $HBoxContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/VBoxContainer/MaxFPS/HBoxContainer/FPSSlider

@onready var master: Label = $HBoxContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/VBoxContainer/Master/HBoxContainer/Master
@onready var master_slider: HSlider = $HBoxContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/VBoxContainer/Master/HBoxContainer/MasterSlider
@onready var sfx: Label = $HBoxContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/VBoxContainer/SFX/HBoxContainer/SFX
@onready var sfx_slider: HSlider = $HBoxContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/VBoxContainer/SFX/HBoxContainer/SFXSlider
@onready var ambient: Label = $HBoxContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/VBoxContainer/Ambient/HBoxContainer/Ambient
@onready var ambient_slider: HSlider = $HBoxContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/VBoxContainer/Ambient/HBoxContainer/AmbientSlider

@onready var sens: Label = $HBoxContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/VBoxContainer/Sensitivity/HBoxContainer/Sens
@onready var sens_slider: HSlider = $HBoxContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/VBoxContainer/Sensitivity/HBoxContainer/SensSlider

@onready var resolution_buttons: OptionButton = $HBoxContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/VBoxContainer/Resolution/ResolutionButtons
@onready var aa_buttons: OptionButton = $HBoxContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/VBoxContainer/AntiAliasing/AAButtons
@onready var vsync_buttons: OptionButton = $"HBoxContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/VBoxContainer/V-Sync/VsyncButtons"

@onready var show_fps_button: Button = $HBoxContainer/VBoxContainer/ScrollContainer/Panel/MarginContainer/VBoxContainer/ShowFPS/ShowFPSButton

@onready var pause: Control = $"../Pause"
@onready var input_menu: InputMenu = $"../InputMenu"

@onready var fps_counter: Label = $"../../FPS"

var sliders: Array[HSlider]

@export_category("Display index")
@export var windowed := 0
@export var fullscreen := 1
@export var windowed_fullscreen := 2

@export_category("V-Sync index")
@export var vsync_off := 0
@export var vsync_on := 1

func _ready() -> void:
	fps_counter.visible = false
	get_tree().root.content_scale_size = Vector2i(1920, 1080)
	
	sliders.append(fov_slider)
	sliders.append(fps_slider)
	sliders.append(master_slider)
	sliders.append(sfx_slider)
	sliders.append(ambient_slider)
	sliders.append(sens_slider)
	
	for slider in sliders:
		slider.value_changed.connect(_on_value_changed.bind(slider))
		slider.value_changed.emit(slider.value)
	
	aa_buttons.item_selected.emit(aa_buttons.get_index())
	vsync_buttons.item_selected.emit(vsync_buttons.get_index())

func _process(_delta: float) -> void:
	fps_counter.text = str(Engine.get_frames_per_second())
	
	if Global.paused:
		return
	
	visible = false

func _on_value_changed(value, sender) -> void:
	var string_value := str(snapped(value, 1))
	
	for slider in sliders:
		if slider != sender:
			continue
		match slider.name:
			"FOVSlider":
				fov.text = string_value
				Global.fov = value
			"FPSSlider":
				fps.text = string_value
				Engine.max_fps = int(value)
			"MasterSlider":
				master.text = string_value
				Global.master_vol = value
			"SFXSlider":
				sfx.text = string_value
				Global.sfx_vol = value
			"AmbientSlider":
				ambient.text = string_value
				Global.ambient_vol = value
			"SensSlider":
				sens.text = string_value
				Global.sens_mod = value

func _on_display_buttons_item_selected(index: int) -> void:
	match index:
		windowed:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		windowed_fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)

func _on_resolution_buttons_item_selected(index: int) -> void:
	var text := resolution_buttons.get_item_text(index)
	
	var parts := text.split("x", false)
	var width := parts[0].strip_edges().to_int()
	var height := parts[1].strip_edges().to_int()
	
	var resolution := Vector2i(width, height)
	
	DisplayServer.window_set_size(resolution)

func _on_vsync_buttons_item_selected(index: int) -> void:
	match index:
		vsync_off:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		vsync_on:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)

func _on_aa_buttons_item_selected(index: int) -> void:
	var msaa = [
		Viewport.MSAA_DISABLED,
		Viewport.MSAA_2X,
		Viewport.MSAA_4X,
		Viewport.MSAA_8X
	]
	
	get_viewport().msaa_3d = msaa[index]

func _on_input_map_button_pressed() -> void:
	visible = false
	input_menu.visible = true

func _on_return_pressed() -> void:
	visible = false
	pause.visible = true

func _on_show_fps_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		show_fps_button.text = "Hide"
		fps_counter.visible = true
	else:
		show_fps_button.text = "Show"
		fps_counter.visible = false
