extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_card_1_pressed() -> void:
	get_tree().root.get_node("Level/ModManager").SpeedMod *= 1.05
	self.visible = false
	
	
 
