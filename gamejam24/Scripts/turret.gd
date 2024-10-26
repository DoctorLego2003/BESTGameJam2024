extends Node2D
@onready var projectile = load("res://turretMissile.tscn")
var enemies = []
var hasBullets = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if len(enemies) > 0 and hasBullets:
		var enemy = enemies[0]
		var diffpos = enemy.global_position - global_position
		$TurretCannon.global_rotation = atan2(diffpos.x, -diffpos.y)
		turret_shoot(delta)
		hasBullets = false
		$Timer.start()
		

func turret_shoot(delta):
	for i in range(3):
		var current_projectile = projectile.instantiate()
		current_projectile.turret = $TurretCannon
		get_parent().get_parent().get_parent().add_child(current_projectile)
		await get_tree().create_timer(0.1).timeout


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		enemies.append(area.get_parent())


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() in enemies:
		enemies.erase(area.get_parent())


func _on_timer_timeout() -> void:
	hasBullets = true
