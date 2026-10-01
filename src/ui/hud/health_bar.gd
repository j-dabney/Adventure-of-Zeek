class_name HealthBar
extends TextureProgressBar

## This needs to be set outside
var character: Character

func init() -> void:
	if not character:
		push_error("Please setup character property before running init()")
		return
	max_value = character.stats.current_max_health
	value = character.stats.health
	character.stats.health_changed.connect(_on_health_changed)

func _on_health_changed() -> void:
	max_value = character.stats.current_max_health
	value = character.stats.health
