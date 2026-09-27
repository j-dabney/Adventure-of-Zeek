@abstract
class_name CharacterController
extends Node

@export var character: Character

@abstract func get_movement_direction() -> Vector3
@abstract func wants_jump() -> bool
@abstract func wants_primary_attack() -> bool
@abstract func wants_secondary_attack() -> bool
@abstract func wants_utility_attack() -> bool
@abstract func wants_special_attack() -> bool
