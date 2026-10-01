extends Node

var _initial_level: String = SceneUIDs.SCENE_UIDS.test_level_01
var _pause_menu: PauseMenu = null

var _main_game: MainGame

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS 

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"pause_menu"):
		_pause_menu.visible = !_pause_menu.visible
		if _pause_menu.visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().paused = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_tree().paused = false

func init(main_game: MainGame) -> void:
	_main_game = main_game
	
	PlayerManager.init(_main_game)
	CameraManager.init(_main_game)
	EnemyManager.init(_main_game)
	
	# Setup PauseMenu and put in pause_root.
	var pause_menu_scene: PackedScene = ResourceLoader.load(SceneUIDs.SCENE_UIDS.pause_menu_scene_uid) as PackedScene
	if pause_menu_scene == null:
		push_error("Could not load pause menu scene: " + SceneUIDs.SCENE_UIDS.pause_menu_scene_uid)
		return
	
	_pause_menu = pause_menu_scene.instantiate() as PauseMenu
	if _pause_menu == null:
		push_error("Loaded pause menu scene does not extend PauseMenu: " + SceneUIDs.SCENE_UIDS.pause_menu_scene_uid)
		return
	
	if not _main_game.pause_root:
		push_error("Main game has not yet been instantiated")
		return
	
	_main_game.pause_root.add_child(_pause_menu)
	
	_pause_menu.visible = false
	
	@warning_ignore("return_value_discarded")
	_pause_menu.quit_button.pressed.connect(on_quit)
	@warning_ignore("return_value_discarded")
	_pause_menu.restart_button.pressed.connect(on_restart)

func start() -> void:
	await LevelLoader.load_level(_initial_level)
	await LevelLoader.load_finished
	
	PlayerManager.place_player_at_level_spawn()
	CameraManager.setup_player_camera()
	EnemyManager.place_enemy_at_level_spawn()

func quit() -> void:
	EnemyManager.cleanup()
	CameraManager.cleanup()
	PlayerManager.cleanup()
	
	print_orphan_nodes()
	_main_game.quit_game()

func restart() -> void:
	EnemyManager.cleanup()
	CameraManager.cleanup()
	PlayerManager.cleanup()
	
	PlayerManager.init(_main_game)
	CameraManager.init(_main_game)
	EnemyManager.init(_main_game)
	
	if not LevelLoader.current_level:
		await LevelLoader.load_level(_initial_level)
		await LevelLoader.load_finished
	
	if not LevelLoader.level_path == _initial_level:
		await LevelLoader.load_level(_initial_level)
		await LevelLoader.load_finished
	
	PlayerManager.place_player_at_level_spawn()
	CameraManager.setup_player_camera()
	EnemyManager.place_enemy_at_level_spawn()

func on_quit() -> void:
	quit()

func on_restart() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	_pause_menu.visible = false
	await restart()
