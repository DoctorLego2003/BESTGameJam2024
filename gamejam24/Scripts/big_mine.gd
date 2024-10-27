extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D/AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_tree().root.get_node("Level/WaveManager").WaveEnded.connect(self.give_money)

func give_money() -> void:
	get_tree().root.get_node("Level/ModManager").Money += 20 * get_tree().root.get_node("Level/ModManager").MoneyMod
