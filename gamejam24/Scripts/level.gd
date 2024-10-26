extends Node2D
func _ready() -> void:
	pass


func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	$PauseScreen.visible = true
	$PauseButton.visible = false
	

#func _input(event):
	#if event.is_action_pressed("Pause"):
		#get_tree().paused = true
		#$PauseScreen.visible = true
		#$PauseButton.visible = false
