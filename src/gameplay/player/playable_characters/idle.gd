extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.x = 0.0
	player.velocity.z = 0.0
	player.animation_player.play("RatAll_Clean")

func physics_update(_delta: float) -> void:
	if not player.is_on_floor(): # If in the air, fall towards the floor.
		player.target_velocity.y = player.target_velocity.y - (player.playable_character_resource.fall_acceleration * _delta)
		
	player.velocity = player.target_velocity
	@warning_ignore("return_value_discarded")
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif player.velocity != Vector3.ZERO:
		finished.emit(WALKING)

func move(direction: Vector3) -> void:
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
	if player.camera:
		direction = direction.rotated(Vector3.UP, player.camera.global_rotation.y)
	
	player.target_velocity.x = direction.x * (player.playable_character_resource.speed + 100)
	player.target_velocity.z = direction.z * (player.playable_character_resource.speed + 100)
