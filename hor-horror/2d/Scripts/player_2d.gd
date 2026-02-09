extends CharacterBody2D
class_name Player2D

@onready var hitbox: CollisionShape2D = $Hitbox
@onready var anim_sprite: AnimatedSprite2D = $Animations
@onready var watch_me: PointLight2D = $PointLight2D
@onready var watch_me2: CollisionShape2D = $Watch/Watch_Me
@onready var point_light: PointLight2D = $PointLight2D2


var death : bool
const speed: int = 70
var current_direction: String = "none"
var dir: String
var Lights: bool 
var bright:= true
var shift_yes:= false
func _ready() -> void:
	death = false

func _physics_process(delta: float) -> void:
	player_movement(delta)
	global_position = global_position.round()
	fleshlight()
	
	if Input.is_action_just_pressed("shift"):
		shift_yes = true
	if Input.is_action_just_released("shift"):
		shift_yes = false

func player_movement(delta):
	
	var input_dir = Vector2.ZERO

	if Input.is_action_pressed("right") and death == false:
		input_dir.x += 1
	if Input.is_action_pressed("left") and death == false:
		input_dir.x -= 1
	if Input.is_action_pressed("down") and death == false:
		input_dir.y += 1
	if Input.is_action_pressed("up") and death == false:
		input_dir.y -= 1

	if input_dir != Vector2.ZERO:
		input_dir = input_dir.normalized()
		velocity = input_dir * speed
		play_anim(1)

		if abs(input_dir.x) > abs(input_dir.y) and shift_yes == false:
			current_direction = "right" if input_dir.x > 0 else "left"
		elif shift_yes == false:
			current_direction = "down" if input_dir.y > 0 else "up"
	else:
		velocity = Vector2.ZERO
		play_anim(0)
	
	move_and_slide()

func play_anim(movement):
	dir = current_direction
	
	if dir == "right" and death == false:
		anim_sprite.flip_h = false
		anim_sprite.play("walk_side" if movement == 1 else "idle_side")
		watch_me.rotation_degrees = -90
		watch_me2.rotation_degrees = -90
	elif dir == "left" and death == false:
		anim_sprite.flip_h = true
		anim_sprite.play("walk_side" if movement == 1 else "idle_side")
		watch_me.rotation_degrees = 90
		watch_me2.rotation_degrees = 90
	elif dir == "down" and death == false:
		anim_sprite.play("walk_front" if movement == 1 else "idle_front")
		watch_me.rotation_degrees = 0
		watch_me2.rotation_degrees = 0
	elif dir == "up" and death == false:
		anim_sprite.play("walk_back" if movement == 1 else "idle_back")
		watch_me.rotation_degrees = 180
		watch_me2.rotation_degrees = 180

func fleshlight():
	if Input.is_action_just_pressed("ui_accept"):
		bright = !bright

		if bright:
			point_light.energy = 1
			watch_me.energy = 1
		else:
			point_light.energy = 0.0
			watch_me.energy = 0.1
