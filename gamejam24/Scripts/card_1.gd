extends Control

@export var cost = 10
@export var cost_text = "10"
@export var ability_text = "DAMAGE 10%"

# Array of options for randomization
var cost_options = [10, 20, 30]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Randomize cost and ability values when the node is ready
	randomize_values()

func randomize_values() -> void:
	# Seed the random number generator for different results on each run
	randomize()
	
	# Select a single random value from cost_options
	var selected_value = cost_options[randi() % cost_options.size()]
	
	# Set cost, cost_text, and ability_text to reflect the selected value
	cost = float(selected_value)
	cost_text = str(cost)
	ability_text = "DAMAGE +" + str(cost_text) + "%"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate() -> void:
	# Access the ModManager node to modify BurstMod and Money
	var mod_manager = get_tree().root.get_node("Level/ModManager")
	mod_manager.DamageMod *= 1 + cost/100
	mod_manager.Money -= cost
