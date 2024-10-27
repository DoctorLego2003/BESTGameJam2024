extends Node2D
var currentBuild = false
@onready var buildUI = get_tree().root.get_node('Level/BuildingUI')
@onready var miner = load("res://Miner.tscn")
@onready var turret = load("res://Turret.tscn")
@onready var acc = load("res://Accelerator.tscn")


func add_building(towerpoint):
	print('building')
	get_parent().add_child(towerpoint.instantiate())
	get_tree().paused = false
	self.queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "PlayerArea":
		currentBuild = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "PlayerArea":
		currentBuild = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Build"):
		if currentBuild:
			get_tree().paused = true
			buildUI.visible = true
			buildUI.ground = self
