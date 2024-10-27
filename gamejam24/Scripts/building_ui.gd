extends Control
@export var ground = null
@onready var miner = load("res://Miner.tscn")
@onready var turret = load("res://Turret.tscn")
@onready var acc = load("res://Accelerator.tscn")
#var cost = 50
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/Miner/Container/AnimatedSprite2D.play()
	$HBoxContainer/Turret/Container/TurretCannon.play()
	$HBoxContainer/Accelerator/Container/IdleAccAnimation.play('idle')



func _on_miner_pressed() -> void:
	if get_tree().root.get_node("Level/ModManager").Money >= 10:
		ground.add_building(miner)
		self.visible = false
		get_tree().root.get_node("Level/ModManager").Money -= 10


func _on_turret_pressed() -> void:
	if get_tree().root.get_node("Level/ModManager").Money >= 50:
		ground.add_building(turret)
		self.visible = false
		get_tree().root.get_node("Level/ModManager").Money -= 50

func _on_accelerator_pressed() -> void:
	if get_tree().root.get_node("Level/ModManager").Money >= 50:
		ground.add_building(acc)
		self.visible = false
		get_tree().root.get_node("Level/ModManager").Money -= 50
		
func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	self.visible = false

func _on_visibility_changed() -> void:
	$HBoxContainer/Miner.disabled = not $HBoxContainer/Miner.disabled
	$HBoxContainer/Turret.disabled = not $HBoxContainer/Turret.disabled
	$HBoxContainer/Accelerator.disabled = not $HBoxContainer/Accelerator.disabled
	
