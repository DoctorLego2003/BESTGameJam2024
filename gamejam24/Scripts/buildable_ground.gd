extends Node2D
var currentBuild = false
@onready var miner = load("res://Miner.tscn")


func add_building(towerpoint):
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "PlayerArea":
		currentBuild = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "PlayerArea":
		currentBuild = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Build"):
		if currentBuild:
			get_parent().add_child(miner.instantiate())
			self.queue_free()
