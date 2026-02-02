extends Node2D
@onready var stairs_b: Area2D = $Stairs_B
@onready var stairs_b_1: CollisionShape2D = $Stairs_B/Stairs_B_1



func _on_stairs_b_area_entered(area: Area2D) -> void:
	print ("change scene")
