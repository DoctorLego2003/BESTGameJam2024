extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_money_display()
	#get_tree().root.print_tree_pretty()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_update_money_display()


# Helper function to update the RichTextLabel text
func _update_money_display() -> void:
	var label = get_node("RichTextLabel")
	label.bbcode_text = get_tree().root.get_node("Level/ModManager").Money
