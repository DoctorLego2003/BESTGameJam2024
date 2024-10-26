extends Node2D

func _ready() -> void:
	$LevelMusic.play()
	

func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	$PauseScreen.visible = true
	$PauseButton.visible = false
	$LevelMusic.volume_db -= 10

func change_music(music):
	$LevelMusic.stream = load("res://music/" + music + ".mp3")
	$LevelMusic.play()
	
