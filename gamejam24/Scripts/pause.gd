extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect button pressed signal if needed
	$Button.connect("pressed", Callable(self, "_on_button_pressed"))
func _on_button_pressed() -> void:
	get_tree().paused = false  # Unpause the game
	hide()  # Hide the pause menu
