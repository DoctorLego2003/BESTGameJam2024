extends Node2D
var Enemy = preload("res://Scripts/Enemy.cs")
var enemies = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if len(enemies) > 0:
		var enemy = enemies[0]
		print(enemy.global_position)
		var diffpos = enemy.global_position - global_position
		$TurretCannon.global_rotation = atan2(diffpos.x, -diffpos.y)



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		enemies.append(area.get_parent())


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() in enemies:
		enemies.erase(area.get_parent())
