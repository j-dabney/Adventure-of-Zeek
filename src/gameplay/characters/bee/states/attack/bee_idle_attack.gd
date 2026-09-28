extends BeeAttackState

func physics_update(_delta: float) -> void:
	if character_controller.wants_primary_attack():
		finished.emit(PRIMARY)
	elif character_controller.wants_secondary_attack():
		finished.emit(SECONDARY)
	elif character_controller.wants_utility_attack():
		finished.emit(UTILITY)
	elif character_controller.wants_special_attack():
		finished.emit(SPECIAL)

@warning_ignore("inferred_declaration")
func enter(_previous_state_path: String, _data := {}) -> void:
	pass
