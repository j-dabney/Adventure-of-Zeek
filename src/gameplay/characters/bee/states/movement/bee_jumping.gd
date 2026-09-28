extends BeeMovementState

func physics_update(delta: float) -> void:
	if not character.is_on_floor(): # If in the air, fall towards the floor.
		target_velocity.y -= character.stats.current_fall_acceleration * delta
	
	character.velocity = target_velocity
	@warning_ignore("return_value_discarded")
	character.move_and_slide()
	
	if character.is_on_floor():
		finished.emit(IDLE)
	if character.velocity.y < 0.0:
		finished.emit(FALLING)
	
@warning_ignore("inferred_declaration")
func enter(_previous_state_path: String, _data := {}) -> void:
	target_velocity = character.velocity
	target_velocity.y = character.stats.current_jump_impulse
	
	@warning_ignore("unsafe_method_access")
	character.character_scene.idle()
