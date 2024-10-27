extends Control

@export var cost = 30
@export var cost_text = "30"
@export var ability_text = "REGEN +1"

# Array of options for randomization

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Randomize cost and ability values when the node is ready
	randomize_values()

func randomize_values() -> void:
	# Seed the random number generator for different results on each run
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate() -> void:
	# Access the ModManager node to modify BurstMod and Money
	var mod_manager = get_tree().root.get_node("Level/ModManager")
	mod_manager.RegenMod += 1
	mod_manager.Money -= cost
