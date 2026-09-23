class_name PlayerState
extends State

const IDLE = "Idle"
const WALKING = "Walking"
const FALLING = "Falling"

var player: PlayableCharacter

func _ready() -> void:
	await owner.ready
	player = owner as PlayableCharacter
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Playable Character node.")

func move(direction: Vector3) -> void:
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
	if player.camera:
		direction = direction.rotated(Vector3.UP, player.camera.global_rotation.y)
	
	if direction != Vector3.ZERO:
		player.model.basis = Basis.looking_at(direction)
	
	player.target_velocity.x = direction.x * player.playable_character_resource.base_walk_speed
	player.target_velocity.z = direction.z * player.playable_character_resource.base_walk_speed
