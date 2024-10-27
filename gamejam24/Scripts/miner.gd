extends Node2D
var currentBuild = false
@onready var upgradeUI = get_tree().root.get_node('Level/UpgradeMinerUI')


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D/AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_tree().root.get_node("Level/WaveManager").WaveEnded.connect(self.give_money)

func give_money() -> void:
	get_tree().root.get_node("Level/ModManager").Money += 10 * get_tree().root.get_node("Level/ModManager").MoneyMod



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
			upgradeUI.visible = true
			upgradeUI.ground = self
			get_tree().paused = true
