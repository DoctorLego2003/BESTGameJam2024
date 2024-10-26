extends Node2D
func _ready() -> void:
	pass

func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	show()
