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
	# Start a timer to delete the projectile after 1 second
	var timer = Timer.new()
	timer.wait_time = 10
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var x = self.rotation
	self.position.y -= speed * delta * cos(x)
	self.position.x += speed * delta * sin(x)

# Function to handle timer timeout
func _on_timer_timeout() -> void:
	queue_free()  # Remove this projectile from the scene
