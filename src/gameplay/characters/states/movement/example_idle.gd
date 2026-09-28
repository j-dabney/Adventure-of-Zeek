extends ExampleMovementState

func physics_update(_delta: float) -> void:
	# if not character.is_on_floor():
	# 	target_velocity.y = character.velocity.y - (character.stats.current_fall_acceleration * _delta)
	# 
	# character.velocity = target_velocity
	# @warning_ignore("return_value_discarded")
	# character.move_and_slide()
	# 
	# if not character.is_on_floor():
	# 	finished.emit(FALLING)
	# if character_controller.wants_jump() and character.is_on_floor():
	# 	finished.emit(JUMPING)
	# if character_controller.get_movement_direction() != Vector3.ZERO:
	# 	finished.emit(SPRINTING)
	pass

@warning_ignore("inferred_declaration")
func enter(_previous_state_path: String, _data := {}) -> void:
	# character.velocity.x = 0.0
	# character.velocity.z = 0.0
	# Play animation if one exists
	# @warning_ignore("unsafe_method_access")
	# character.character_scene.idle()
	pass
