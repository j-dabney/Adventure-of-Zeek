extends Node

var current_camera: Node3D = null

var _entity_root: Node3D = null

func init() -> void:
	if not RootNodes.entity_root:
		push_error("Camera Manager was initalized before root nodes.")
		return
		
	_entity_root = RootNodes.entity_root
	
	if not LevelLoader.current_level:
		return
	
	if not PlayerManager.player:
		return
	
	setup_player_camera()

func setup_player_camera() -> void:
	if not _entity_root or not LevelLoader.current_level or not PlayerManager.player:
		return
	
	if current_camera:
		PlayerManager.player.camera = null
		_entity_root.remove_child(current_camera)
		current_camera.queue_free()
		current_camera = null
	
	var camera_scene: PackedScene = ResourceLoader.load(SceneUIDs.SCENE_UIDS.pivot_camera_scene_uid) as PackedScene
	if camera_scene == null:
		push_error("Could not load camera scene: " + SceneUIDs.SCENE_UIDS.pivot_camera_scene_uid)
		return
	
	current_camera = camera_scene.instantiate() as PivotCamera
	if current_camera == null:
		push_error("Loaded camera scene does not extend BaseCamera: " + SceneUIDs.SCENE_UIDS.pivot_camera_scene_uid)
		return
	
	_entity_root.add_child(current_camera)
	
	@warning_ignore("unsafe_property_access")
	current_camera.target = PlayerManager.player
	PlayerManager.player.camera = current_camera
	@warning_ignore("untyped_declaration")
	var player_input_controller_script = load("res://src/gameplay/player/player_input_controller.gd")
	PlayerManager.player.input_controller.set_script(player_input_controller_script)
	PlayerManager.player.input_controller.character = PlayerManager.player

func switch_to_debug_camera() -> void:
	if not _entity_root or not LevelLoader.current_level:
		return
	
	if current_camera:
		PlayerManager.player.camera = null
		_entity_root.remove_child(current_camera)
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
	
	_entity_root.add_child(current_camera)
	
	PlayerManager.player_input_controller.set_script(null)
