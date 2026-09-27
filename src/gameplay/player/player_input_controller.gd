class_name PlayerInputController
extends CharacterController

var direction: Vector3

func get_movement_direction() -> Vector3:
	direction = Vector3(Input.get_axis('move_left', 'move_right'), 0.0, Input.get_axis('move_forward', 'move_back')).normalized()
	
	if character.camera:
		direction = direction.rotated(Vector3.UP, character.camera.global_rotation.y)
	
	return direction

func wants_jump() -> bool:
	return Input.is_action_just_pressed("jump")

func wants_primary_attack() -> bool:
	return Input.is_action_just_pressed("primary")

func wants_secondary_attack() -> bool:
	return Input.is_action_just_pressed("secondary")

func wants_utility_attack() -> bool:
	return Input.is_action_just_pressed("utility")

func wants_special_attack() -> bool:
	return Input.is_action_just_pressed("special")
