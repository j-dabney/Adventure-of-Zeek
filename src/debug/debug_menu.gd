extends Control

@onready var pause_game: CheckButton

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_menu"):
		visible = !visible

func _on_pause_game_toggled(toggled_on: bool) -> void:
	get_tree().paused = !get_tree().paused
