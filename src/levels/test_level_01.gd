extends BaseLevel

@onready var player_spawn: Marker3D = $LevelObjects/PlayerSpawn
@onready var player_camera: BaseCamera = $LevelObjects/PlayerCamera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

## Provides a player spawn location
func get_default_player_spawn() -> Vector3:
	return player_spawn.global_position

## Provides the camera used in the level
func get_player_camera() -> BaseCamera:
	return player_camera
