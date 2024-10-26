extends Node2D
@export var speed = 100
@export var damage = 1
var planetPos 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = get_parent().get_node("PlayerOrbit/Player")
	self.global_position = player.global_position
	self.global_rotation = player.global_rotation
	print(position)
	print(rotation)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var x = self.rotation
	self.position.y -= speed * delta * cos(x)
	self.position.x += speed * delta * sin(x)
