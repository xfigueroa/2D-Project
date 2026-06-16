extends Area2D

signal collected

var _consumed := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if _consumed:
		return
	if body.has_method("grow"):
		_consumed = true
		body.grow()
		collected.emit()
		queue_free()
