extends Node

signal progress_changed(progress: float)
signal load_finished

var current_level: BaseLevel = null

var loading_screen: PackedScene = preload(SceneUIDs.SCENE_UIDS.loading_screen_uid)
var loaded_level: PackedScene
var level_path: String
var progress: Array = []
var use_sub_threads: bool = true

var _main_game: MainGame = null

func _ready() -> void:
	set_process(false)

## Takes the Node representing the MainGame as an argument and caches it.
func init(main_game: MainGame) -> void:
	_main_game = main_game

func load_level(_level_path: String) -> void:
	level_path = _level_path
	
	if not _main_game.level_root or not _main_game.transition_root:
		printerr("Main scene has not been initiated.")
		return
	
	var new_load_screen: LoadingScreen = loading_screen.instantiate()
	if not new_load_screen:
		printerr("Could not instantiate new load screen")
		return
	if not new_load_screen is LoadingScreen:
		printerr("New load screen is not of type LoadingScreen")
		return
	
	_main_game.transition_root.add_child(new_load_screen)
	@warning_ignore("return_value_discarded")
	progress_changed.connect(new_load_screen._on_progress_changed)
	@warning_ignore("return_value_discarded")
	load_finished.connect(new_load_screen._on_load_finished)

	await new_load_screen.loading_screen_ready

	start_load()

func start_load() -> void:
	var state: Error = ResourceLoader.load_threaded_request(level_path, "", use_sub_threads)
	if state == OK:
		set_process(true)

func _process(_delta: float) -> void:
	var load_status: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(level_path, progress)
	progress_changed.emit(progress[0])
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			loaded_level = ResourceLoader.load_threaded_get(level_path)
			
			if current_level:
				_main_game.level_root.remove_child(current_level)
				current_level.queue_free()
				current_level = null
			
			for child: Node in _main_game.level_root.get_children():
				_main_game.level_root.remove_child(child)
				child.queue_free()
			
			var new_level: Node = loaded_level.instantiate()
	
			if not new_level:
				push_error("Could not instantiate new level")
				set_process(false)
				return
			
			if not new_level is BaseLevel:
				new_level.free() # Level must be removed from the tree
				push_error("Loaded level is not of type BaseLevel")
				set_process(false)
				return
			
			current_level = new_level
			
			_main_game.level_root.add_child(current_level)
			load_finished.emit()
			set_process(false)
