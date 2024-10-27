extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D/IdleAccAnimation.play('idle')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	area.get_parent().speed *= 2
	$Area2D/IdleAccAnimation.play('accelerating')


func _on_idle_acc_animation_animation_finished() -> void:
	$Area2D/IdleAccAnimation.play('idle')
