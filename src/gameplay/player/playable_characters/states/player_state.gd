class_name PlayerState
extends State

const IDLE = "Idle"
const WALKING = "Walking"
const SPRINTING = "Sprinting"
const JUMPING = "Jumping"
const FALLING = "Falling"

const PRIMARY_ATTACK = "PrimaryAttack"
const SECONDARY_ATTACK = "SecondaryAttack"
const UTILITY_ATTACK = "UtilityAttack"
const SPECIAL_ATTACK = "SpecialAttack"

var player: PlayableCharacter

func _ready() -> void:
	await owner.ready
	player = owner as PlayableCharacter
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Playable Character node.")

func move(direction: Vector3) -> void:
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		player.model.basis = Basis.looking_at(direction)
	
	if player.camera:
		direction = direction.rotated(Vector3.UP, player.camera.global_rotation.y)
	
	player.target_velocity.x = direction.x * player.playable_character_resource.base_walk_speed
	player.target_velocity.z = direction.z * player.playable_character_resource.base_walk_speed
