extends Node3D
class_name Item

@onready var floor_cast: ShapeCast3D = $FloorCast

var gravity = -9.8
var direction: Vector3
var speed := 12.5

var thrown := false

func _physics_process(delta: float) -> void:
	if !thrown:
		return
	
	if direction != Vector3.ZERO:
		direction =lerp(direction, Vector3.ZERO, delta)
		global_position += direction * speed * delta
	
	if !floor_cast.is_colliding():
		position.y += gravity / 175
	else:
		direction = Vector3.ZERO

func launch(dir: Vector3):
	direction = dir.normalized()
