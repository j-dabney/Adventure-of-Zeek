class_name PlayableCharacter
extends CharacterBody3D
## Base class for playable characters. Must define a resource and separate node for each one.

@export var playable_character_resource: PlayableCharacterResource
@export var camera: BaseCamera

var target_velocity: Vector3 = Vector3.ZERO

func _physics_process(delta: float) -> void:
	if not is_on_floor(): # If in the air, fall towards the floor.
		target_velocity.y = target_velocity.y - (playable_character_resource.fall_acceleration * delta)
		
	velocity = target_velocity
	move_and_slide()

func move(direction: Vector3) -> void:
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
	if camera:
		direction = direction.rotated(Vector3.UP, camera.global_rotation.y)
	
	target_velocity.x = direction.x * playable_character_resource.speed
	target_velocity.z = direction.z * playable_character_resource.speed
