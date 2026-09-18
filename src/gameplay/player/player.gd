class_name Player
extends Node3D

@export var camera : BaseCamera
@onready var character : CharacterBody3D = $Character

var target_velocity = Vector3.ZERO

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
	if camera:
		direction = direction.rotated(Vector3.UP, camera.global_rotation.y)
		character.global_rotation.y = camera.global_rotation.y
	
	target_velocity.x = direction.x * character.speed
	target_velocity.z = direction.z * character.speed
	
	if not character.is_on_floor(): # If in the air, fall towards the floor.
		target_velocity.y = target_velocity.y - (character.fall_acceleration * delta)
		
	character.velocity = target_velocity
	character.move_and_slide()
	
	global_position = character.global_position
