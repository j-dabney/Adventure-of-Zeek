class_name MovementState
extends State

const IDLE: String = "Idle"
const SPRINTING: String = "Sprinting"
const JUMPING: String = "Jumping"
const FALLING: String = "Falling"

var character: Character
var character_controller: CharacterController

var target_velocity: Vector3 = Vector3.ZERO

func _ready() -> void:
	character = owner as Character
	character_controller = character.input_controller as CharacterController
