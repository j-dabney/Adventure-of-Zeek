extends PlayerState

func physics_update(delta: float) -> void:
	if not player.is_on_floor(): # If in the air, fall towards the floor.
		player.target_velocity.y = player.target_velocity.y - (player.playable_character_resource.base_fall_acceleration * delta)
	
	player.velocity = player.target_velocity
	@warning_ignore("return_value_discarded")
	player.move_and_slide()
	
	if player.is_on_floor():
		finished.emit(IDLE)

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("RatAll_Itch")
