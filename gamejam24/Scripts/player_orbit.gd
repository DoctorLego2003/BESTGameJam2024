extends Node2D
var moveLeft = false
var moveRight = false
@export var speed = 3
var projectile = load("res://projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if moveLeft:
		self.rotate(speed * delta)
	if moveRight:
		self.rotate(-speed * delta)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("clockwise-move"):
		moveLeft = true
	elif event.is_action_released("clockwise-move"):
		moveLeft = false
	if event.is_action_pressed("anticlockwise-move"):
		moveRight = true
	elif event.is_action_released("anticlockwise-move"):
		moveRight = false
	if event.is_action_pressed("shoot"):
		var current_projectile = projectile.instantiate()
		get_tree().root.print_tree_pretty()
		current_projectile.speed = 250 * get_tree().root.get_node("Level/ModManager").SpeedMod
		get_parent().add_child(current_projectile)
