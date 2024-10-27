extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Area2D/AnimatedSprite2D.play("default")
	get_tree().root.get_node("Level/WaveManager").WaveEnded.connect(self.give_money)

func give_money() -> void:
	get_tree().root.get_node("Level/ModManager").Money += 10
