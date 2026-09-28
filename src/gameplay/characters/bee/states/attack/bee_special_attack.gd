extends BeeAttackState

var timer: float

func physics_update(delta: float) -> void:
	timer -= delta
	
	if timer <= 0.0:
		finished.emit(IDLE)

@warning_ignore("inferred_declaration")
func enter(_previous_state_path: String, _data := {}) -> void:
	# Play animation if one exists
	
	timer = 0.5
	print("Special Attack was used!")
