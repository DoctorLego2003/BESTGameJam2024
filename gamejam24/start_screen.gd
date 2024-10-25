extends Control

var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = str(counter)
	$Button.connect("pressed", Callable(self, "_on_button_pressed"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_button_pressed() -> void:
	if counter < 100:
		counter += 1
		$Label.text = str(counter)
