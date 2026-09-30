extends Control

@onready var pause_game: CheckButton
@onready var fly_camera: CheckButton

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_menu"):
		visible = !visible

func _on_pause_game_toggled(toggled_on: bool) -> void:
	get_tree().paused = !get_tree().paused


func _on_fly_camera_toggled(toggled_on: bool) -> void:
	if toggled_on:
		CameraManager.switch_to_debug_camera()
	else:
		CameraManager.setup_player_camera()
