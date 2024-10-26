extends Node2D


func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	$PauseScreen.visible = true
	$PauseButton.visible = false
	
