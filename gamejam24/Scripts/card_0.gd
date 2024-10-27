extends Control

@export var cost = 10
@export var cost_text = "10"
@export var ability_text = "BURST +1"
var ability = 1

# Array of options for randomization
var cost_options = [30, 60, 90]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Randomize cost and ability values when the node is ready
	randomize_values()

func randomize_values() -> void:
	# Seed the random number generator for different results on each run
	randomize()
	
	# Choose a random cost from cost_options
	cost = cost_options[randi() % cost_options.size()]
	
	# Set ability based on cost (1 for 10, 2 for 20, 3 for 30)
	ability = float(cost / 10)
	
	# Update cost_text to match the new cost
	cost_text = str(cost)
	
	# Update ability_text to show the correct burst value
	ability_text = "BURST +" + str(ability)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate() -> void:
	# Access the ModManager node to modify BurstMod and Money
	var mod_manager = get_tree().root.get_node("Level/ModManager")
	mod_manager.BurstMod += ability
	mod_manager.Money -= cost
