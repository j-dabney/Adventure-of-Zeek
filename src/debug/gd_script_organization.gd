@tool
@icon("res://path/to/icon.svg")
class_name PascalCase
extends Node
## Brief description of class
##
## Longer documentation goes here

# signals
signal something_happened(value : int)

# enums (PascalCase, members are CONSTANT_CASE)
enum EnumName
{
	ITEM_1,
	ITEM_2
}

# constants (CONSTANT_CASE)
const CONSTANT_VARIABLE : float = 19.84

# export-variables (snake_case)
@export var exported_variable : float = 0.0

# public variables (non-underscore-prefixed snake_case)
var is_a_public_variable : bool = false

# private variables (underscore-prefixed _snake_case)
var _this_is_private : bool = true

# onready-variables (snake_case)
@onready var on_ready_var : Sprite2D = $Sprite2D

# Optional built-in virtual methods
# _init()
# _enter_tree()
# _ready()

# Remaining built-in virtual methods
func _ready() -> void:
	pass

func _process(_delta : float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

# public methods (non-underscore-prefixed snake_case)
func do_a_thing(the_thing : Thing) -> void:
	pass

# private methods (underscore-prefixed _snake_case)
func _do_a_thing_but_private() -> float:
	return 3.29

# Callback
func _on_a_thing_happening() -> void:
	pass

# Inner class
class InnerClassName:
	pass
