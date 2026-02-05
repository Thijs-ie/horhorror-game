extends CharacterBody3D
class_name WeepingAngel2D

var observed := true
var player: Player3D

var speed := 5

func _physics_process(delta: float) -> void:
	if Global.paused || observed:
		return
	
	if !player:
		for child in get_parent().get_children():
			if child as Player3D:
				player = child
		return
	
	var direction := player.global_position - global_position
	
	direction.y = 0.0
	
	if direction.length() > 0.01:
		direction = direction.normalized()
		velocity.x = lerp(velocity.x, direction.x * speed, delta)
		velocity.z = lerp(velocity.z, direction.z * speed, delta)
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	move_and_slide()
	
	move_and_slide()


func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	observed = true

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	observed = false
