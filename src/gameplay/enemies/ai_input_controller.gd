class_name AIInputController
extends CharacterController

@export var target: Node3D
@export var parent: Character
var direction: Vector3

func get_movement_direction() -> Vector3:
	if not target:
		return Vector3.ZERO
		
	direction = parent.global_position.direction_to(target.global_position).normalized()
	
	return direction

func wants_jump() -> bool:
	return false

func wants_primary_attack() -> bool:
	return false

func wants_secondary_attack() -> bool:
	return false

func wants_utility_attack() -> bool:
	return false

func wants_special_attack() -> bool:
	return false
