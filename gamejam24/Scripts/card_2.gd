extends Control
@export var cost = 10
@export var cost_text = "10"
@export var ability_text = "MONEY 10%"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate() -> void:
		get_tree().root.get_node("Level/ModManager").MoneyMod *= 1.1
		get_tree().root.get_node("Level/ModManager").Money -= 10

		
