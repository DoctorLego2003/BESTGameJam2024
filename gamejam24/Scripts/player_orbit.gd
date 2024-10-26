extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action("clockwise-move"):
		self.rotate(0.1)
	elif event.is_action("anticlockwise-move"):
		self.rotate(-0.1)
