@abstract
class_name BaseLevel
extends Node3D
## Abstract class for levels

## Provides a player spawn location
@abstract func get_default_player_spawn() -> Vector3

## Provides an enemy spawn location
@abstract func get_default_enemy_spawn() -> Vector3
