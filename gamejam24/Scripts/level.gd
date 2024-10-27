extends Node2D

func _ready() -> void:
	$LevelMusic.play()
	get_tree().paused = false
	wave_counter()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wave_counter()

func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	$PauseScreen.visible = true
	$PauseButton.visible = false
	$LevelMusic.volume_db -= 10

func change_music(music):
	$LevelMusic.stream = load("res://music/" + music + ".mp3")
	$LevelMusic.play()
	
func wave_counter() -> void:
	get_node("WaveCounter").text = "Wave " + str(get_node("WaveManager").GetCurrentWave())
