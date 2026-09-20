class_name Player
extends CharacterBody3D

@export var character: PlayableCharacter

var target_velocity = Vector3.ZERO
var character_scene: Node3D

func _ready() -> void:
	character_scene = character.playable_character_scene.instantiate()
	$Pivot.add_child(character_scene)

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO
	$"Pivot/Sketchfab_Scene/AnimationPlayer".play("RatAll_Clean")

	
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
	
	direction = direction.rotated(Vector3.UP, $Camera.global_rotation.y)
	
	target_velocity.x = direction.x * character.speed
	target_velocity.z = direction.z * character.speed
	
	if not is_on_floor(): # If in the air, fall towards the floor.
		target_velocity.y = target_velocity.y - (character.fall_acceleration * delta)
		
	velocity = target_velocity
	move_and_slide()
