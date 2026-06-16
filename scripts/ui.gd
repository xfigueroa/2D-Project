extends CanvasLayer

@onready var counter: Label = $HBox/Counter

var orb_count := 0

func _ready() -> void:
	get_parent().orb_collected.connect(_on_orb_collected)

func _on_orb_collected() -> void:
	orb_count += 1
	counter.text = "x" + str(orb_count)
