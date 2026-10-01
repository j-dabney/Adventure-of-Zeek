extends Node

var current_camera: Node3D = null

var _main_game: MainGame = null

## Takes the Node representing the MainGame as an argument and caches it.
## Assumes MainGame has an entity_root.
## IMPORTANT: Must not be initialized before PlayerManager or LevelLoader
func init(main_game: MainGame) -> void:
	_main_game = main_game
	
	if not LevelLoader.current_level:
		return
	
	if not PlayerManager.player:
		return
	
	setup_player_camera()

func setup_player_camera() -> void:
	if not _main_game.entity_root or not LevelLoader.current_level or not PlayerManager.player:
		return
	
	if current_camera:
		PlayerManager.player.camera = null
		_main_game.entity_root.remove_child(current_camera)
		current_camera.queue_free()
		current_camera = null
	
	var camera_scene: PackedScene = ResourceLoader.load(SceneUIDs.SCENE_UIDS.pivot_camera_scene_uid) as PackedScene
	if camera_scene == null:
		push_error("Could not load camera scene: " + SceneUIDs.SCENE_UIDS.pivot_camera_scene_uid)
		return
	
	current_camera = camera_scene.instantiate() as PivotCamera
	if current_camera == null:
		push_error("Loaded camera scene does not extend PivotCamera: " + SceneUIDs.SCENE_UIDS.pivot_camera_scene_uid)
		return
	
	_main_game.entity_root.add_child(current_camera)
	
	@warning_ignore("unsafe_property_access")
	current_camera.target = PlayerManager.player
	PlayerManager.player.camera = current_camera
	PlayerManager.player.input_controller.enabled = true

func switch_to_debug_camera() -> void:
	if not _main_game.entity_root or not LevelLoader.current_level:
		return
	
	if current_camera:
		PlayerManager.player.camera = null
		_main_game.entity_root.remove_child(current_camera)
		current_camera.queue_free()
		current_camera = null
	
	var camera_scene: PackedScene = ResourceLoader.load(SceneUIDs.SCENE_UIDS.fly_camera_scene_uid) as PackedScene
	if camera_scene == null:
		push_error("Could not load camera scene: " + SceneUIDs.SCENE_UIDS.fly_camera_scene_uid)
		return
	
	current_camera = camera_scene.instantiate() as FlyCamera
	if current_camera == null:
		push_error("Loaded camera scene does not extend BaseCamera: " + SceneUIDs.SCENE_UIDS.fly_camera_scene_uid)
		return
	
	_main_game.entity_root.add_child(current_camera)
	
	PlayerManager.player.input_controller.enabled = false
