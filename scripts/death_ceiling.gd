extends Area2D

@export var start_speed: float = 50.0
@export var max_speed: float = 250.0
@export var acceleration: float = 4.0

var _speed: float

func _ready() -> void:
	_speed = start_speed
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	_speed = minf(_speed + acceleration * delta, max_speed)
	position.y += _speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().call_deferred("reload_current_scene")
