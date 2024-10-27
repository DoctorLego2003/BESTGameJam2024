extends Control
@export var ground = null
@onready var miner = load("res://TurretDouble.tscn")
@onready var turret = load("res://Turret.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/TurretDouble/Container/AnimatedSprite2D.play()
	#$HBoxContainer/TurretThunk/Container/AnimatedSprite2D.play()



func _on_turret_double_pressed() -> void:
	ground.add_building(miner)
	self.visible = false


func _on_turret_thunk_pressed() -> void:
	ground.add_building(turret)
	self.visible = false



func _on_visibility_changed() -> void:
	$HBoxContainer/TurretDouble.disabled = not $HBoxContainer/TurretDouble.disabled
	$HBoxContainer/TurretThunk.disabled = not $HBoxContainer/TurretThunk.disabled
