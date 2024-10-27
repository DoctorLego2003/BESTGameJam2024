extends Area2D
@onready var _animated_sprite = $MoonAnimation



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position.x = 577
	self.position.y = 323
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var lives = get_tree().root.get_node("Level/ModManager").HealthMod
	if lives > 0:
		_animated_sprite.play()
	else:
		self.visible = false
		get_parent().pause = true
	
