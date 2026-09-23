class_name PlayableCharacter
extends CharacterBody3D
## Base class for playable characters. Must define a resource and separate node for each one.

@export var playable_character_resource: PlayableCharacterResource
@export var camera: BaseCamera
@export var animation_player: AnimationPlayer
@export var state_machine: StateMachine
@export var model: Node3D

var target_velocity: Vector3 = Vector3.ZERO

func _ready() -> void:
	# Check if Asset has pre-made animation player
	if $Asset/AnimationPlayer:
		animation_player = $Asset/AnimationPlayer
