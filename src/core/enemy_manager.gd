extends Node

var enemy: Character = null

var _main_game: MainGame = null

## Takes the Node representing the MainGame as an argument and caches it.
## Assumes MainGame has an entity_root.
func init(main_game: MainGame) -> void:
	_main_game = main_game
	
	var enemy_scene: PackedScene = ResourceLoader.load(SceneUIDs.SCENE_UIDS.enemy_scene_uid) as PackedScene
	if enemy_scene == null:
		push_error("Could not load enemy scene: " + SceneUIDs.SCENE_UIDS.enemy_scene_uid)
		return
	
	enemy = enemy_scene.instantiate() as Character
	if enemy == null:
		push_error("Loaded enemy scene does not extend character or DNE: " + SceneUIDs.SCENE_UIDS.enemy_scene_uid)
		return
	
	_main_game.entity_root.add_child(enemy)

func place_enemy_at_level_spawn() -> void:
	if enemy == null:
		push_error("Cannot place enemy in level because enemy is null")
		return
	if LevelLoader.current_level == null:
		push_error("Cannot place enemy into level because level is null")
		return
	
	enemy.global_position = LevelLoader.current_level.get_default_enemy_spawn()
	(enemy.input_controller as AIInputController).target = PlayerManager.player

func cleanup() -> void:
	if enemy:
		_main_game.entity_root.remove_child(enemy)
		enemy.queue_free()
		enemy = null
