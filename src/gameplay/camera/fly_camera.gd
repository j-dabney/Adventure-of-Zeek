class_name FlyCamera
extends Camera3D

@export var move_speed: float = 10.0
@export var mouse_sensitivity: float = 0.002
@export var fast_multiplier: float = 2.0

var rot_x: float = 0.0
var rot_y: float = 0.0

func _ready() -> void:
	# Capture mouse cursor (press Escape to release if needed)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rot_y -= event.relative.x * mouse_sensitivity
		rot_x -= event.relative.y * mouse_sensitivity
		# Clamp vertical rotation to avoid flipping
		rot_x = clamp(rot_x, -PI / 2.0, PI / 2.0)
		transform.basis = Basis()
		rotate_y(rot_y)
		rotate_object_local(Vector3.RIGHT, rot_x)
		
	if event.is_action_pressed("toggle_mouse_capture"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	var speed = move_speed
	if Input.is_key_pressed(KEY_SHIFT):
		speed *= fast_multiplier

	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_back"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x
	if Input.is_action_pressed("jump"):
		direction += Vector3.UP
	if Input.is_key_pressed(KEY_CTRL):
		direction -= Vector3.UP

	global_translate(direction.normalized() * speed * delta)
