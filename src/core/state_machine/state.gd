class_name State
extends Node
## Virtual base class for all states.
## Extend this class and override its methods to implement a state.

## Emitted when the state finishes and wants to transition to another state.
@warning_ignore("unused_signal")
signal finished(next_state_path: String, data: Dictionary)

## Called by the state machine when receiving unhandled input events.
@warning_ignore("unused_parameter")
func handle_input(event: InputEvent) -> void:
	pass

## Called by the state machine on the engine's main loop tick.
@warning_ignore("unused_parameter")
func update(delta: float) -> void:
	pass

## Called by the state machine on the engine's physics update tick.
@warning_ignore("unused_parameter")
func physics_update(delta: float) -> void:
	pass

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
@warning_ignore("inferred_declaration", "unused_parameter")
func enter(previous_state_path: String, data := {}) -> void:
	pass

## Called by the state machine before changing the active state. Use this function
## to clean up the state.
func exit() -> void:
	pass
