extends BaseLevel

@onready var player_spawn : Marker3D = $LevelObjects/PlayerSpawn
@onready var camera : Camera3D = $LevelObjects/CameraPivot/Camera3D

## Provides a player spawn location
func get_default_player_spawn() -> Vector3:
	return player_spawn.position

## Provides the camera used in the level
func get_player_camera() -> Camera3D:
	return camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
