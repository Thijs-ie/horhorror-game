extends CharacterBody3D
class_name Hand

@onready var skeleton_3d: Skeleton3D = $Hand2/Armature/Skeleton3D
@onready var stun_timer: Timer = $StunTimer

var player: Player3D

var stunned := false

var amplitude := 0.1
var wave_speed := 3.0
var time := 0.0

var speed := 3.5

var start_position: Vector3

func _ready():
	start_position = skeleton_3d.position

func _physics_process(delta: float) -> void:
	if Global.paused:
		return
	
	if !player:
		for child in get_parent().get_children():
			if child as Player3D:
				player = child
		return
	
	time += delta * wave_speed
	skeleton_3d.position.y = start_position.y + sin(time) * amplitude
	
	if stunned:
		if stun_timer.is_stopped():
			stun_timer.start()
		return
	
	
	
	look_at(player.position)
	
	var direction := player.global_position - global_position
	
	direction.y = 0.0
	
	if direction.length() > 0.01:
		direction = direction.normalized()
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 2)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 2)
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	move_and_slide()

func _on_stun_timer_timeout() -> void:
	stunned = false
