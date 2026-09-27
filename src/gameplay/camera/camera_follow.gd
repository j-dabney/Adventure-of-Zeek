extends Camera3D

@export var spring_arm: Node3D
@export var lerp_power: float = 1.0

func _physics_process(delta: float) -> void:
	position = lerp(position, spring_arm.position, delta * lerp_power)
