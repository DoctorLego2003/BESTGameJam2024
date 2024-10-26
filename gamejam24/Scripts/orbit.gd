extends Node2D
@export var step = 0.5
@export var spots = 9
@export var distance = 80
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(spots):
		var new_child = Container.new()
		new_child.position.x = distance*cos(2*3.14159265*i/spots)
		new_child.position.y = distance*sin(2*3.14159265*i/spots)
		new_child.rotation = 2*3.14159265*i/spots
		new_child.add_child(load("res://Miner.tscn").instantiate())
		add_child(new_child)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for child in self.get_children():
		self.rotate(delta*step*0.1)
		

func add_building(towertype):
	pass
