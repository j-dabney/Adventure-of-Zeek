class_name CharacterController
extends Node

@export var character: Character
var enabled: bool

func get_movement_direction() -> Vector3:
	return Vector3.ZERO
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
