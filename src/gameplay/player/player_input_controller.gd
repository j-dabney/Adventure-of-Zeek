class_name PlayerInputController
extends CharacterController

var direction: Vector3

func get_movement_direction() -> Vector3:
	if not enabled:
		return Vector3.ZERO
	
	direction = Vector3(Input.get_axis('move_left', 'move_right'), 0.0, Input.get_axis('move_forward', 'move_back')).normalized()
	
	return direction

func wants_jump() -> bool:
	if not enabled:
		return false
	
	return Input.is_action_just_pressed("jump")

func wants_primary_attack() -> bool:
	if not enabled:
		return false
	
	return Input.is_action_just_pressed("primary")

func wants_secondary_attack() -> bool:
	if not enabled:
		return false
	
	return Input.is_action_just_pressed("secondary")

func wants_utility_attack() -> bool:
	if not enabled:
		return false
	
	return Input.is_action_just_pressed("utility")

func wants_special_attack() -> bool:
	if not enabled:
		return false
	
	return Input.is_action_just_pressed("special")
