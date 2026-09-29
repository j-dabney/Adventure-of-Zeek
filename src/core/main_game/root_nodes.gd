extends Node

var level_root: Node3D = null:
	set(new_level_root):
		level_root = new_level_root
	get:
		return level_root

var entity_root: Node3D = null:
	set(new_entity_root):
		entity_root = new_entity_root
	get:
		return entity_root

var effect_root: Node3D = null:
	set(new_effect_root):
		effect_root = new_effect_root
	get:
		return effect_root

var hud_root: Control = null:
	set(new_hud_root):
		hud_root = new_hud_root
	get:
		return hud_root

var pause_root: Control = null:
	set(new_pause_root):
		pause_root = new_pause_root
	get:
		return pause_root

var transition_root: Control = null:
	set(new_transition_root):
		transition_root = new_transition_root
	get:
		return transition_root

var debug_root: Control = null:
	set(new_debug_root):
		debug_root = new_debug_root
	get:
		return debug_root
