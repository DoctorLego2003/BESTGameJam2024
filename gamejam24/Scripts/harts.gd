extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hearts()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hearts()
	

func hearts() -> void:
	get_tree().root.get_node("Level/WaveManager").WaveEnded.connect(self.add_hearths)
	get_node("Health").text = str(get_tree().root.get_node("Level/ModManager").RegenMod)
	get_node("Health").text += "/"
	get_node("Health").text += str(get_tree().root.get_node("Level/ModManager").HealthMod)

func add_hearths() -> void:
	get_tree().root.get_node("Level/ModManager").HealthMod += get_tree().root.get_node("Level/ModManager").RegenMod
