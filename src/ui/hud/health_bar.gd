class_name HealthBar
extends TextureProgressBar

func _ready() -> void:
	visible = false
	PlayerManager.player_spawned.connect(_on_player_spawned)

func _on_player_spawned() -> void:
	max_value = PlayerManager.player.stats.current_max_health
	value = PlayerManager.player.stats.health
	PlayerManager.player.stats.health_changed.connect(_on_health_changed)
	visible = true

func _on_health_changed() -> void:
	max_value = PlayerManager.player.stats.current_max_health
	value = PlayerManager.player.stats.health
