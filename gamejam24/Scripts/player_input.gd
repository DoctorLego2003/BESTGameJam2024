extends Node2D
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("clockwise-move"):
		get_parent().moveLeft = true
	elif event.is_action_released("clockwise-move"):
		get_parent().moveLeft = false
	if event.is_action_pressed("anticlockwise-move"):
		get_parent().moveRight = true
	elif event.is_action_released("anticlockwise-move"):
		get_parent().moveRight = false
