extends Node

var text_overlay: Control
var menu: Control

var _main_game: MainGame = null

## Takes the Node representing the MainGame as an argument and caches it.
## Assumes MainGame has a debug_root.
func init(main_game: MainGame) -> void:
	_main_game = main_game
	
	var text_overlay_scene: PackedScene = ResourceLoader.load(SceneUIDs.SCENE_UIDS.debug_text_overlay_scene_uid) as PackedScene
	if text_overlay_scene == null:
		push_error("Could not load debug text overlay scene: " + SceneUIDs.SCENE_UIDS.debug_text_overlay_scene_uid)
		return
	
	text_overlay = text_overlay_scene.instantiate() as Control
	if text_overlay == null:
		push_error("Loaded debug text overlay scene does not extend Control: " + SceneUIDs.SCENE_UIDS.debug_text_overlay_scene_uid)
		return
	
	_main_game.debug_root.add_child(text_overlay)
	
	var menu_scene: PackedScene = ResourceLoader.load(SceneUIDs.SCENE_UIDS.debug_menu_scene_uid) as PackedScene
	if menu_scene == null:
		push_error("Could not load debug menu scene: " + SceneUIDs.SCENE_UIDS.debug_menu_scene_uid)
		return
	
	menu = menu_scene.instantiate() as Control
	if menu == null:
		push_error("Loaded debug menu scene does not extend Control: " + SceneUIDs.SCENE_UIDS.debug_menu_scene_uid)
		return
	
	_main_game.debug_root.add_child(menu)
