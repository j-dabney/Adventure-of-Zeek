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
	PlayerManager.init(self)
	CameraManager.init(self)
	EnemyManager.init(self)
	
	await LevelLoader.load_level(SceneUIDs.SCENE_UIDS.test_level_01)
	await LevelLoader.load_finished
	
	PlayerManager.place_player_at_level_spawn()
	CameraManager.setup_player_camera()
	EnemyManager.place_enemy_at_level_spawn()

func _unhandled_input(event: InputEvent) -> void:
	if not OS.is_debug_build():
		return
	
	if event.is_action_pressed(&"debug_quit"):
		print_orphan_nodes()
		quit_game()

func quit_game() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
