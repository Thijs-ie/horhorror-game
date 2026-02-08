extends Marker3D
class_name IKTarget

@export var step_target: Marker3D
@export var step_distance := 1.0

var is_stepping := false

func _process(_delta: float) -> void:
	if !is_stepping && abs(global_position.distance_to(step_target.global_position)) > step_distance:
		step()

func step():
	var target_pos = step_target.global_position
	var half_way = (global_position + step_target.global_position) / 2
	is_stepping = true
	
	var t = get_tree().create_tween()
	t.tween_property(self, "global_position", half_way + owner.basis.y / 2, 0.1)
	t.tween_property(self, "global_position", target_pos, 0.1)
	t.tween_callback(func(): is_stepping = false)
