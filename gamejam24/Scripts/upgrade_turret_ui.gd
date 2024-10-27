extends Control
@export var ground = null
@onready var turretDouble = load("res://turretDouble.tscn")
@onready var turretThunk = load("res://TurretThunk.tscn")
var cost = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/TurretDouble/Container/TurretCannon.play()
	$HBoxContainer/TurretThunk/Container/TurretCannon.play()



func _on_turret_double_pressed() -> void:
	if get_tree().root.get_node("Level/ModManager").Money >= cost:
		ground.add_building(turretDouble)
		self.visible = false
		get_tree().root.get_node("Level/ModManager").Money -= cost


func _on_turret_thunk_pressed() -> void:
	if get_tree().root.get_node("Level/ModManager").Money >= cost:
		ground.add_building(turretThunk)
		self.visible = false
		get_tree().root.get_node("Level/ModManager").Money -= cost


func _on_visibility_changed() -> void:
	$HBoxContainer/TurretDouble.disabled = not $HBoxContainer/TurretDouble.disabled
	$HBoxContainer/TurretThunk.disabled = not $HBoxContainer/TurretThunk.disabled
