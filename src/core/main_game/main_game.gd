class_name MainGame
extends Node
## Main entry point for the game.
## Responsible for setting up the World Layers and coordinating high-level systems.

# FUTURE (main menu): Load test level for prototype

var player: Character = null
var enemy: Character = null

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
	_init_player()
	_init_enemy()
	RootNodes.level_root = level_root
	RootNodes.entity_root = entity_root
	RootNodes.effect_root = effect_root
	RootNodes.hud_root = hud_root
	RootNodes.pause_root = pause_root
	RootNodes.transition_root = transition_root
	RootNodes.debug_root = debug_root
	
	await LevelLoader.load_level(SceneUIDs.SCENE_UIDS.test_level_01)
	await LevelLoader.load_finished
	
	_place_player_at_level_spawn.call_deferred()
	_setup_level_camera.call_deferred()
	_place_enemy_at_level_spawn.call_deferred()

func _unhandled_input(event: InputEvent) -> void:
	if not OS.is_debug_build():
		return
	
	if event.is_action_pressed(&"debug_quit"):
		print_orphan_nodes()
		quit_game()

func quit_game() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

# Instantiates the player and adds it to the entity layer
func _init_player() -> void:
	var player_scene: PackedScene = ResourceLoader.load(SceneUIDs.SCENE_UIDS.player_scene_uid) as PackedScene
	if player_scene == null:
		push_error("Could not load player scene: " + SceneUIDs.SCENE_UIDS.player_scene_uid)
		return
	
	player = player_scene.instantiate() as Character
	if player == null:
		push_error("Loaded player scene does not extend player or DNE: " + SceneUIDs.SCENE_UIDS.player_scene_uid)
		return
	
	entity_root.add_child(player)

## Finds the default spawn location in currently loaded level, and places
## the Player at that position.
func _place_player_at_level_spawn() -> void:
	if player == null:
		push_error("Cannot place player in level because player is null")
		return
	if LevelLoader.current_level == null:
		push_error("Cannot place player into level because level is null")
		return
	
	player.global_position = LevelLoader.current_level.get_default_player_spawn()
	# FUTURE (Player HUD): Make this not dumb
	var player_hud: HealthBar = $HUDLayer/HUDRoot/PlayerHUD/Health/HealthBar
	player_hud.player = player

## Attaches player to the current camera as the camera pivot position
func _setup_level_camera() -> void:
	if player == null or LevelLoader.current_level == null:
		return
	
	var level_camera: BaseCamera = LevelLoader.current_level.get_player_camera()
	if level_camera == null:
		return
	
	# FUTURE (camera): Temporary hookup
	# Will become: camera_system.set_target(player)
	level_camera.target = player
	player.camera = level_camera

func _init_enemy() -> void:
	var enemy_scene: PackedScene = ResourceLoader.load(SceneUIDs.SCENE_UIDS.enemy_scene_uid) as PackedScene
	if enemy_scene == null:
		push_error("Could not load enemy scene: " + SceneUIDs.SCENE_UIDS.enemy_scene_uid)
		return
	
	enemy = enemy_scene.instantiate() as Character
	if enemy == null:
		push_error("Loaded enemy scene does not extend character or DNE: " + SceneUIDs.SCENE_UIDS.enemy_scene_uid)
		return
	
	entity_root.add_child(enemy)

func _place_enemy_at_level_spawn() -> void:
	if enemy == null:
		push_error("Cannot place enemy in level because enemy is null")
		return
	if LevelLoader.current_level == null:
		push_error("Cannot place enemy into level because level is null")
		return
	
	enemy.global_position = LevelLoader.current_level.get_default_enemy_spawn()
	(enemy.input_controller as AIInputController).target = player
