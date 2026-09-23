class_name PlayerInputController
extends Node3D

@export var character: PlayableCharacter

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var direction: Vector3 = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	
	character.state_machine.state.move(direction)
