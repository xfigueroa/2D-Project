extends RigidBody2D

@export var move_force: float = 800.0
@export var max_horizontal_speed: float = 300.0

var input_left: String = "ui_left"
var input_right: String = "ui_right"

func setup(left_action: String, right_action: String) -> void:
	input_left = left_action
	input_right = right_action

func _physics_process(_delta: float) -> void:
	var direction := 0.0
	if Input.is_action_pressed(input_left):
		direction -= 1.0
	if Input.is_action_pressed(input_right):
		direction += 1.0

	if direction != 0.0:
		apply_central_force(Vector2(direction * move_force, 0.0))

	# Clamp horizontal speed so the ball doesn't slide forever
	if abs(linear_velocity.x) > max_horizontal_speed:
		linear_velocity.x = sign(linear_velocity.x) * max_horizontal_speed
