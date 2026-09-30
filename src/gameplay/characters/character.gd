class_name Character
extends CharacterBody3D
## Base class for characters. Must define a resource and separate node for each one.

@export var stats: Stats
@export var camera: PivotCamera
@export var movement_state_machine: StateMachine
@export var attack_state_machine: StateMachine
@export var character_scene: Node3D
@export var input_controller: CharacterController
