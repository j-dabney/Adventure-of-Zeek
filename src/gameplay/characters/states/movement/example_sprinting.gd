extends ExampleMovementState

# var direction: Vector3

func physics_update(delta: float) -> void:
	# if not character.is_on_floor(): # If in the air, fall towards the floor.
	# 	target_velocity.y -= character.stats.current_fall_acceleration * delta
	# 
	# if direction != Vector3.ZERO:
	# 	var target_basis: Basis = Basis.looking_at(direction, Vector3.UP, true)
	# 	character.character_scene.basis = character.character_scene.basis.slerp(target_basis, delta * 10.0)
	
	# Ground Velocity
	# target_velocity.x = direction.x * character.stats.current_sprint_speed
	# target_velocity.z = direction.z * character.stats.current_sprint_speed
	# 
	# character.velocity = target_velocity
	# @warning_ignore("return_value_discarded")
	# character.move_and_slide()
	# 
	# direction = character_controller.get_movement_direction()
	# 
	# if not character.is_on_floor():
	# 	finished.emit(FALLING)
	# elif character.is_on_floor() and character_controller.wants_jump():
	# 	finished.emit(JUMPING)
	# elif character.velocity == Vector3.ZERO:
	# 	finished.emit(IDLE)
	pass

@warning_ignore("inferred_declaration")
func enter(_previous_state_path: String, _data := {}) -> void:
	# direction = character_controller.get_movement_direction()
	
	# Play animation if one exists
	# @warning_ignore("unsafe_method_access")
	# character.character_scene.move()
	pass
