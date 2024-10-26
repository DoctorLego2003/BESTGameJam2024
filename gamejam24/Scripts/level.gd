extends Node2D
func _ready() -> void:
	pass


func _on_pausse_button_pressed() -> void:
	get_tree().paused = true
	$PauseScreen.visible = true
	$PauseButton.visible = false
