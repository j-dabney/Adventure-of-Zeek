extends CharacterBody3D

@export var speed = 14
@export var fall_acceleration = 75

func _process(delta: float) -> void:
	$"Pivot/Rat Model/AnimationPlayer".play("RatAll_Clean")
