extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hearts()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hearts()
	

func hearts() -> void:
	get_node("Health").text = str(get_tree().root.get_node("Level/ModManager").HealthMod)
