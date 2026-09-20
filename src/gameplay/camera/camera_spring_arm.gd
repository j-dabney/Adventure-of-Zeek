class_name BaseCamera
extends Node3D

@export var mouse_sensibility: float = 0.005
@export var camera_y_offset: float = 0.961
@export var target: Node3D
@export_range(-90.0, 0.0, 0.1, "radians_as_degrees") var min_vertical_angle: float = -PI/2
@export_range(0.0, 90.0, 0.1, "radians_as_degrees") var max_vertical_angle: float = PI/4
@export_range(0.0, 4.0, 0.1) var min_camera_distance: float = 3.0
@export_range(5.0, 20.0, 0.1) var max_camera_distance: float = 9.0

@onready var spring_arm: SpringArm3D = $SpringArm3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if target != null:
		global_position = Vector3(target.global_position.x, target.global_position.y + camera_y_offset, target.global_position.z)

func _process(_delta: float) -> void:
	if target != null:
		global_position = Vector3(target.global_position.x, target.global_position.y + camera_y_offset, target.global_position.z)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var mouse_event: InputEventMouseMotion = event as InputEventMouseMotion
		if not mouse_event:
			return

		rotation.y -= mouse_event.relative.x * mouse_sensibility
		rotation.y = wrapf(rotation.y, 0.0, TAU)
		
		rotation.x -= mouse_event.relative.y * mouse_sensibility
		rotation.x = clamp(rotation.x, min_vertical_angle, max_vertical_angle)
	
	if event.is_action_pressed("zoom_in"):
		spring_arm.spring_length -= 1
	if event.is_action_pressed("zoom_out"):
		spring_arm.spring_length += 1
	spring_arm.spring_length = clamp(spring_arm.spring_length, min_camera_distance, max_camera_distance)
	
	if event.is_action_pressed("toggle_mouse_capture"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
