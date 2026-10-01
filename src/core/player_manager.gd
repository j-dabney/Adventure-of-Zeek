extends Node

signal player_spawned

var player: Character = null
var player_hud: PlayerHUD = null

var _main_game: MainGame = null

## Takes the Node representing the MainGame as an argument and caches it.
## Assumes MainGame has a entity_root and hud_root.
func init(main_game: MainGame) -> void:
	_main_game = main_game
	
	# Setup Player and put in entity_root.
	var player_scene: PackedScene = ResourceLoader.load(SceneUIDs.SCENE_UIDS.player_scene_uid) as PackedScene
	if player_scene == null:
		push_error("Could not load player scene: " + SceneUIDs.SCENE_UIDS.player_scene_uid)
		return
	
	player = player_scene.instantiate() as Character
	if player == null:
		push_error("Loaded enemy scene does not extend character or DNE: " + SceneUIDs.SCENE_UIDS.player_scene_uid)
		return
	
	if not _main_game.entity_root:
		push_error("Main game has not yet been instantiated")
		return
	
	_main_game.entity_root.add_child(player)
	
	# Setup Player HUD and put in hud_root.
	var player_hud_scene: PackedScene = ResourceLoader.load(SceneUIDs.SCENE_UIDS.player_hud_scene_uid) as PackedScene
	if player_hud_scene == null:
		push_error("Could not load player hud scene: " + SceneUIDs.SCENE_UIDS.player_hud_scene_uid)
		return
	
	player_hud = player_hud_scene.instantiate() as PlayerHUD
	if player_hud == null:
		push_error("Loaded Player HUD scene does not extend PlayerHUD: " + SceneUIDs.SCENE_UIDS.player_hud_scene_uid)
		return
	
	if not _main_game.hud_root:
		push_error("Main game has not yet been instantiated")
		return
	
	_main_game.hud_root.add_child(player_hud)
	
	# Player HUD health bar needs reference to Player
	player_hud.health_bar.character = player
	
	# Player HUD shouldn't be visible until Player is in level
	player_hud.visible = false

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
	
	# Player HUD should be visible once Player spawns
	player_hud.visible = true

func cleanup() -> void:
	if player_hud:
		_main_game.hud_root.remove_child(player_hud)
		player_hud.queue_free()
		player_hud = null
	
	if player:
		_main_game.entity_root.remove_child(player)
		player.queue_free()
		player = null
