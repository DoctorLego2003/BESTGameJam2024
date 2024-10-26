extends Node2D
@export var speed = 5
@export var damage = 1
var planetPos 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	planetPos = get_parent().position
	self.position = get_parent().get_node("player").position
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
