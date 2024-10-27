extends Node2D
@export var speed = 1
@export var damage = 5
@export var explosive = false

var planetPos 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var speed = get_tree().root.get_node('Level/ModManager').ProjectileSpeedMod
	var damage = get_tree().root.get_node('Level/ModManager').DamageMod
	print(damage)
	var player = get_parent().get_node("PlayerOrbit/Player")
	self.global_position = player.global_position
	self.global_rotation = player.global_rotation
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
		speed = 0
		$Area2D/hitAnimation.visible = true
		$Area2D/hitAnimation.play()
		$Area2D/Sprite2D.visible = false
		if explosive:
			$Area2D/CollisionShape2D.shape = CircleShape2D
			$Area2D/CollisionShape2D.scale * 4
			$Area2D/explosionAnimation.play()
		$Area2D/CollisionShape2D.disabled = true

func _on_hit_animation_animation_finished() -> void:
	self.queue_free()
