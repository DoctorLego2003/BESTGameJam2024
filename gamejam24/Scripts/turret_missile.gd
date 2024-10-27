extends Node2D
@export var speed = 300
@export var damage = 1
@export var turret = null
var planetPos 
@onready var EnemyScript = preload("res://scripts/Enemy.cs")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.global_position = turret.global_position
	self.global_rotation = turret.global_rotation
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


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		area.get_parent().TakeDamage(damage)
		$Area2D/Missile.visible = false
		$Area2D/hitAnimation.visible = true
		$Area2D/hitAnimation.play()


func _on_hit_animation_animation_finished() -> void:
	self.queue_free()
