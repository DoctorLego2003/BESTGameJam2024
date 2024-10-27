extends Node2D
@onready var projectile = load("res://turretMissile.tscn")
var enemies = []
var hasBullets = true
var bulletAmount = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	follow_emeny()
	if len(enemies) > 0 and hasBullets:
		$reloadTimer.start()
		$TurretCannon.play()
		turret_shoot()
		$fireTimer.start()
		hasBullets = false


func follow_emeny():
	if len(enemies) > 0:
		var enemy = enemies[0]
		var diffpos = enemy.global_position - global_position
		$TurretCannon.global_rotation = atan2(diffpos.x, -diffpos.y)

func turret_shoot():
	var current_projectile = projectile.instantiate()
	current_projectile.location.x -= 40
	current_projectile.turret = $TurretCannon
	get_parent().get_parent().get_parent().add_child(current_projectile)
	var current_projectile2 = projectile.instantiate()
	current_projectile.location += 40
	current_projectile2.turret = $TurretCannon
	get_parent().get_parent().get_parent().add_child(current_projectile2)
	$TurretShootSound.play()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		enemies.append(area.get_parent())


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() in enemies:
		enemies.erase(area.get_parent())


func _on_reload_timer_timeout() -> void:
	hasBullets = true
	bulletAmount = 3


func _on_fire_timer_timeout() -> void:
	bulletAmount -=1
	if bulletAmount > 0:
		turret_shoot()
		$fireTimer.start()