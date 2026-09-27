class_name Stats
extends Resource

enum ScalingStats {
	MAX_HEALTH,
	MAX_SHIELD,
	ATTACK,
	DEFENSE
}

enum BuffableStats {
	MAX_HEALTH,
	MAX_SHIELD,
	ATTACK,
	DEFENSE,
	SPRINT_SPEED,
	FALL_ACCELERATION,
	JUMP_IMPULSE
}

const STAT_CURVES: Dictionary[ScalingStats, Curve] = {
	ScalingStats.MAX_HEALTH: preload("uid://dpe8et2i6itxu"),
	ScalingStats.MAX_SHIELD: preload("uid://dk3wfm100nkkh"),
	ScalingStats.ATTACK: preload("uid://brt86m2ysy7b2"),
	ScalingStats.DEFENSE: preload("uid://dvfry4mq1kd0u")
}

signal health_depleted
signal health_changed(health: int, max_health: int)

@export var name: String
@export var description: String

@export var base_max_health: int
@export var base_max_shield: int
@export var base_attack: int
@export var base_defense: int
@export var experience: int: set = _on_experience_set

@export var base_sprint_speed: int
@export var base_fall_acceleration: int
@export var base_jump_impulse: int

var current_max_health: int
var current_max_shield: int
var current_attack: int
var current_defense: int
var level: int:
	get(): return floor(max(1.0, sqrt(experience / 100.0) + 0.5))

var current_sprint_speed: int
var current_fall_acceleration: int
var current_jump_impulse: int

var health: int = 0: set = _on_health_set

var stat_buffs: Array[StatBuff]

func _init() -> void:
	setup_stats.call_deferred()

func setup_stats() -> void:
	recalculate_stats()
	health = current_max_health

func add_buff(buff: StatBuff) -> void:
	stat_buffs.append(buff)
	recalculate_stats.call_deferred()

func remove_buff(buff: StatBuff) -> void:
	stat_buffs.erase(buff)
	recalculate_stats.call_deferred()

func recalculate_stats() -> void:
	var stat_multipliers: Dictionary = {}
	var stat_addends: Dictionary = {}
	for buff: StatBuff in stat_buffs:
		@warning_ignore("unsafe_cast")
		var stat_name: String = (BuffableStats.keys()[buff.stat] as String).to_lower()
		match buff.buff_type:
			StatBuff.BuffType.ADD:
				if not stat_addends.has(stat_name):
					stat_addends[stat_name] = 0.0
				stat_addends[stat_name] += buff.buff_amount
			
			StatBuff.BuffType.MULTIPLY:
				if not stat_multipliers.has(stat_name):
					stat_multipliers[stat_name] = 1.0
				stat_multipliers[stat_name] += buff.buff_amount
				
				if stat_multipliers[stat_name] < 0.0:
					stat_multipliers[stat_name] = 0.0
			
	
	var stat_sample_pos: float = (float(level) / 100.0) - 0.01
	@warning_ignore("narrowing_conversion")
	current_max_health = base_max_health * STAT_CURVES[ScalingStats.MAX_HEALTH].sample(stat_sample_pos)
	@warning_ignore("narrowing_conversion")
	current_max_shield = base_max_shield * STAT_CURVES[ScalingStats.MAX_SHIELD].sample(stat_sample_pos)
	@warning_ignore("narrowing_conversion")
	current_attack = base_attack * STAT_CURVES[ScalingStats.ATTACK].sample(stat_sample_pos)
	@warning_ignore("narrowing_conversion")
	current_defense = base_defense * STAT_CURVES[ScalingStats.DEFENSE].sample(stat_sample_pos)

	current_sprint_speed = base_sprint_speed
	current_fall_acceleration = base_fall_acceleration
	current_jump_impulse = base_jump_impulse
	
	@warning_ignore("untyped_declaration")
	for stat_name in stat_multipliers:
		var cur_property_name: String = str("current_" + stat_name)
		set(cur_property_name, get(cur_property_name) * stat_multipliers[stat_name])
	
	@warning_ignore("untyped_declaration")
	for stat_name in stat_addends:
		var cur_property_name: String = str("current_" + stat_name)
		set(cur_property_name, get(cur_property_name) + stat_addends[stat_name])

func _on_health_set(new_value: int) -> void:
	health = clampi(new_value, 0, current_max_health)
	health_changed.emit(health, current_max_health)
	if health <= 0:
		health_depleted.emit()

func _on_experience_set(new_value: int) -> void:
	var old_level: int = level
	experience = new_value
	
	if not old_level == level:
		recalculate_stats()
