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
	


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Enemy"):
		if !body.stunned:
			body.stunned = true
		self.queue_free()
