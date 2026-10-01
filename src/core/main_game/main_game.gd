class_name MainGame
extends Node
## Main entry point for the game.
## Responsible for setting up the World Layers and coordinating high-level systems.

# Game World root nodes
@onready var level_root: Node3D = %LevelRoot
@onready var entity_root: Node3D = %EntityRoot
@onready var effect_root: Node3D = %EffectRoot

# UI Root Nodes (FUTURE)
@onready var hud_root: Control = %HUDRoot
@onready var pause_root: Control = %PauseRoot
@onready var transition_root: Control = %TransitionRoot
@onready var debug_root: Control = %DebugRoot

func _ready() -> void:
	DebugManager.init(self)
	LevelLoader.init(self)
	GameManager.init(self)
	
	@warning_ignore("missing_await")
	GameManager.start()

func _unhandled_input(event: InputEvent) -> void:
	if not OS.is_debug_build():
		return
	
	if event.is_action_pressed(&"debug_quit"):
		GameManager.quit()

func quit_game() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
