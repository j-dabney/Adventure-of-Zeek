class_name AIInputController
extends CharacterController

@export var target: Node3D

var direction: Vector3

func _ready() -> void:
	@warning_ignore("return_value_discarded")
	PlayerManager.player_spawned.connect(_on_player_spawned)
	target = PlayerManager.player
	enabled = false

func get_movement_direction() -> Vector3:
	if not enabled:
		return Vector3.ZERO
	
	if not target:
		return Vector3.ZERO
		
	direction = character.global_position.direction_to(target.global_position)
	
	return direction
	
func _on_player_spawned() -> void:
	target = PlayerManager.player
