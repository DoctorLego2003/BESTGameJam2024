extends Node2D
@onready var projectile = load("res://turretMissile.tscn")
var enemies = []
var hasBullets = true
var bulletAmount = 3
var currentBuild = false
@onready var upgradeUI = get_tree().root.get_node('Level/UpgradeTurretUI')

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
	current_projectile.turret = $TurretCannon
	get_parent().get_parent().get_parent().add_child(current_projectile)
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
		

func add_building(towerpoint):
	print('upgrading')
	get_parent().add_child(towerpoint.instantiate())
	get_tree().paused = false
	self.queue_free()



func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if area.name == "PlayerArea":
		currentBuild = true


func _on_area_2d_2_area_exited(area: Area2D) -> void:
	if area.name == "PlayerArea":
		currentBuild = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Build"):
		if currentBuild:
			enemies = []
			upgradeUI.visible = true
			upgradeUI.ground = self
			get_tree().paused = true
