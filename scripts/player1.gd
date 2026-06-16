extends RigidBody2D

signal orb_collected

@export var move_force: float = 2000.0
@export var max_speed: float = 500.0
@export var input_kick: float = 150.0
@export var jump_force: float = 450.0
@export var grow_amount: float = 1

var _grounded := false

func _ready() -> void:
	add_to_group("player")

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	_grounded = false
	for i in state.get_contact_count():
		if state.get_contact_local_normal(i).y < -0.5:
			_grounded = true
			break

func _physics_process(_delta: float) -> void:
	var dir_x := 0.0
	if Input.is_action_pressed("p1_left"):
		dir_x -= 1.0
	if Input.is_action_pressed("p1_right"):
		dir_x += 1.0

	if dir_x != 0.0:
		if sign(dir_x) != sign(linear_velocity.x):
			linear_velocity.x = dir_x * input_kick
		apply_central_force(Vector2(dir_x * move_force, 0.0))

	if abs(linear_velocity.x) > max_speed:
		linear_velocity.x = sign(linear_velocity.x) * max_speed

	if Input.is_action_just_pressed("p1_jump") and _grounded:
		linear_velocity.y = -jump_force

func grow() -> void:
	var collision := $Collision as CollisionShape2D
	var visual := $Visual as ColorRect
	var new_radius: float = (collision.shape as CircleShape2D).radius + grow_amount
	(collision.shape as CircleShape2D).radius = new_radius
	visual.offset_left = -new_radius
	visual.offset_top = -new_radius
	visual.offset_right = new_radius
	visual.offset_bottom = new_radius
	orb_collected.emit()
