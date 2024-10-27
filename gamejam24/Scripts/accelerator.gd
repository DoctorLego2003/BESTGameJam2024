extends Node2D
var upgradedShell = preload("res://assets/art/sprites/shell_accelerated.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D/IdleAccAnimation.play('idle')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectiles"):
		area.get_parent().explosive = true
		area.get_parent().speed *= 2
		area.get_parent().damage *= 2
		area.get_parent().get_node("Area2D/Sprite2D").texture = upgradedShell
		$Area2D/IdleAccAnimation.play('accelerating')
		$acceleration.play()


func _on_idle_acc_animation_animation_finished() -> void:
	$Area2D/IdleAccAnimation.play('idle')
