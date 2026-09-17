@abstract
class_name BaseLevel
extends Node3D
## Abstract class for levels

## Provides a player spawn location
@abstract func get_default_player_spawn() -> Vector3

## Provides the camera used in the level
@abstract func get_player_camera() -> Camera3D
