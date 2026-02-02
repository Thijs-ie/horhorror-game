extends Camera3D
class_name Cam3D

@onready var player: Player3D = $"../.."
@onready var head: Node3D = $".."

var camera_speed := 0.002
var mouse_input := Vector2.ZERO
var sensitivity : float

const BREATHING_FREQ: = 0.2
const BREATHING_AMP: = 0.3
var t_breath: = 0.0
var breath_rotation = Vector2.ZERO

const bobbing_freq = 1.5
const bobbing_amp = 0.03
var t_bob = 0.0

func _input(event: InputEvent) -> void:
	if Global.paused:
		return
	if event is InputEventMouseMotion:
		player.rotation.y -= event.relative.x * camera_speed * sensitivity
		rotation.x -= event.relative.y * camera_speed * sensitivity
		rotation.x = clamp(rotation.x, -1.25, 1.5)
		mouse_input = event.relative

func _physics_process(delta: float) -> void:
	fov = Global.fov
	
	if Global.paused:
		return
	
	var velocity = player.velocity
	var input_dir = player.input_dir
	
	sensitivity = Global.sens_mod / 100 * 2
	
	t_bob += delta * velocity.length() * float(player.is_on_floor())
	transform.origin = headbob(t_bob)
	
	t_breath += delta
	breath_rotation = breathing(t_breath)
	head.rotation_degrees = breathing(t_breath)
	
	camera_tilt(delta, input_dir.x)

func breathing(delta) -> Vector3:
	var cam_rotation: = Vector3.ZERO
	cam_rotation.x = sin(delta * BREATHING_FREQ * TAU) * BREATHING_AMP
	cam_rotation.y = cos(delta * BREATHING_FREQ * TAU / 2) * BREATHING_AMP * 0.5
	return cam_rotation

func camera_tilt(delta, input_x):
	rotation.z = lerp(rotation.z, -input_x * 0.025, delta * 2.0)

func headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * bobbing_freq) * bobbing_amp
	pos.x = cos(time * bobbing_freq / 2) * bobbing_amp
	return pos
