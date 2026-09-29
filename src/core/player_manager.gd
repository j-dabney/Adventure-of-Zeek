extends Node

signal player_spawned

var player: Character
var player_input_controller: PlayerInputController

func init() -> void:
	var player_scene: PackedScene = ResourceLoader.load(SceneUIDs.SCENE_UIDS.player_scene_uid) as PackedScene
	if player_scene == null:
		push_error("Could not load player scene: " + SceneUIDs.SCENE_UIDS.player_scene_uid)
		return
	
	player = player_scene.instantiate() as Character
	if player == null:
		push_error("Loaded enemy scene does not extend character or DNE: " + SceneUIDs.SCENE_UIDS.player_scene_uid)
		return
	
	if not RootNodes.entity_root:
		push_error("Main game has not yet been instantiated")
		return
	
	RootNodes.entity_root.add_child(player)

## Finds the default spawn location in currently loaded level, and places
## the Player at that position.
func place_player_at_level_spawn() -> void:
	if player == null:
		push_error("Cannot place player in level because player is null")
		return
	if LevelLoader.current_level == null:
		push_error("Cannot place player into level because level is null")
		return
	
	player.global_position = LevelLoader.current_level.get_default_player_spawn()
	player_spawned.emit()
