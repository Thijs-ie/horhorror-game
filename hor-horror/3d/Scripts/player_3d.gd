extends CharacterBody3D
class_name Player3D

@onready var pause_menu: Control = $CanvasLayer/PauseMenu
@onready var camera: Camera3D = $Head/Camera
@onready var detection_cast: RayCast3D = $Head/Camera/DetectionCast
@onready var hand: Node3D = $Head/Camera/Hand

var item := preload("res://3d/Scenes/throwable_item.tscn")
var held_item: Item

var speed : float
var accel : float = 10.0
var drag : float = 8.0
var dash_speed := 50.0

var input_dir := Vector2.ZERO
var mouse_input := Vector2.ZERO

func _ready() -> void:
	pause_menu.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		Global.pause()
		pause_menu.visible = Global.paused
	

func _physics_process(delta: float) -> void:
	if Global.paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		return
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if !is_on_floor():
		velocity += get_gravity() * delta * 1.2
	
	
	var direction := (global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	move(delta, accel, drag, direction, speed)
	move_and_slide()
	
	
	if global_position.y <= -35:
		global_position = Vector3.ZERO
	
	if is_instance_valid(detection_cast.get_collider()):
		if detection_cast.is_colliding() && Input.is_action_just_pressed("interact"):
			detection(detection_cast.get_collider())
	
	if held_item && Input.is_action_just_released("throw"):
		throw()

@warning_ignore("shadowed_variable")
func move(delta: float, accel: float, drag: float, direction: Vector3, speed: float) -> void:
	input_dir = Input.get_vector("left", "right", "up", "down")
	var wish_vel := direction * speed
	
	if is_on_floor():
		if direction:
			velocity.x = lerp(velocity.x, wish_vel.x, delta * accel)
			velocity.z = lerp(velocity.z, wish_vel.z, delta * accel)
		else:
			velocity.x = lerp(velocity.x, 0.0, delta * drag)
			velocity.z = lerp(velocity.z, 0.0, delta * drag)
	else:
		velocity.x = lerp(velocity.x, wish_vel.x, delta * (accel * 0.5))
		velocity.z = lerp(velocity.z, wish_vel.z, delta * (accel * 0.5))

func detection(collider):
	if held_item:
		return
	
	collider = collider.get_parent()
	
	if collider as Item:
		
		collider.queue_free()
		
		var instance = item.instantiate()
		hand.add_child(instance)
		held_item = instance

func throw():
	held_item.thrown = true
	var item_pos = held_item.global_position
	held_item.reparent(get_parent())
	held_item.global_position = item_pos
	held_item = null
