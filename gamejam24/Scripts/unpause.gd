extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().paused = false
	self.visible = false
	get_parent().get_node("PauseButton").visible = true

#func _input(event):
	#if event.is_action_pressed("Pause"):
		#get_tree().paused = false
		#self.visible = false
		#get_parent().get_node("PauseButton").visible = true



func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()


func _on_settings_pressed() -> void:
	get_node("PauseScreen/Settings/Music").visible = true
	get_node("PauseScreen/Settings/Sound").visible = true
	get_node("PauseScreen/PauseSettings").visible = false
