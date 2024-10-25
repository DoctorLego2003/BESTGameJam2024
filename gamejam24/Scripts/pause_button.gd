extends Button

# Variable to keep track of the game's pause state
var is_paused = false

# Called when the button is pressed
func _on_PauseButton_pressed():
	toggle_pause()

# Function to toggle the pause state
func toggle_pause():
	is_paused = !is_paused

	if is_paused:
		# Pause the game
		get_tree().paused = true
		# Optionally, show a pause menu here
		print("Game Paused")
	else:
		# Resume the game
		get_tree().paused = false
		# Optionally, hide the pause menu here
		print("Game Resumed")
