extends Node3D
class_name Item

@onready var floor_cast: ShapeCast3D = $FloorCast

var gravity = 9.8
var direction: Vector3
var speed := 10.5

var thrown := false

var gravity_direction: float

func _physics_process(delta: float) -> void:
	if !thrown || floor_cast.is_colliding():
		return
	
	gravity_direction -= gravity * delta
	
	if !floor_cast.is_colliding():
		direction = Vector3(0, gravity_direction, -speed)
	
	position += transform.basis * direction * delta
	

func launch(dir: Vector3):
	direction = dir.normalized()
