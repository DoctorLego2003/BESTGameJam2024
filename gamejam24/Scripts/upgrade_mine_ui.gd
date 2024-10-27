extends Control
@export var ground = null
@onready var bigMine = load("res://BigMine.tscn")
var cost = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/BigMine/Container/TurretCannon.play()

func _on_big_mine_pressed() -> void:
	if get_tree().root.get_node("Level/ModManager").Money >= cost:
		ground.add_building(bigMine)
		self.visible = false
		get_tree().root.get_node("Level/ModManager").Money -= cost


func _on_visibility_changed() -> void:
	$HBoxContainer/BigMine.disabled = not $HBoxContainer/BigMine.disabled
