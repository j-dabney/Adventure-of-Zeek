class_name HealthBar
extends TextureProgressBar

@export var player: Character

func _process(_delta: float) -> void:
	if not player:
		return
	if not visible and player:
		visible = true
	
	max_value = player.stats.current_max_health
	value = player.stats.health

func _ready() -> void:
	init.call_deferred()
	
	if not player:
		visible = false

func init() -> void:
	if not player:
		return
	max_value = player.stats.current_max_health
	value = player.stats.health
