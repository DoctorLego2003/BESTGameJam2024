extends Control

var cards_directory = "res://cards/"
# This array will store loaded card textures
var card_images = []
var card_properties = []
var rx = 0
var ry = 0
var rz = 0


func _process(delta: float) -> void:
		pass

func _ready() -> void:
	#$Card1.visible = false
	#$Card2.visible = false
	#$Card3.visible = false
	
	get_tree().root.get_node("Level/WaveManager").WaveEnded.connect(self._new_wave)
	
func _on_card_1_pressed() -> void:
	if get_tree().root.get_node("Level/ModManager").Money >= get_parent().get_node("ActivationFunctions").get_child(rx).cost:
		get_parent().get_node("ActivationFunctions").get_child(rx).activate()
		$Card1.icon = load("res://cards/hidden/card" + str(rx) + ".png")
		$Card1.disabled = true
	#get_tree().root.get_node("Level/ModManager").HealthMod -= 1
	

func _on_card_2_pressed() -> void:
	if get_tree().root.get_node("Level/ModManager").Money >= get_parent().get_node("ActivationFunctions").get_child(ry).cost:
		get_parent().get_node("ActivationFunctions").get_child(ry).activate()
		$Card2.icon = load("res://cards/hidden/card" + str(ry) + ".png")
		$Card2.disabled = true

func _on_card_3_pressed() -> void:
	if get_tree().root.get_node("Level/ModManager").Money >= get_parent().get_node("ActivationFunctions").get_child(rz).cost:
		get_parent().get_node("ActivationFunctions").get_child(rz).activate()
		$Card3.icon = load("res://cards/hidden/card" + str(rz) + ".png")
		$Card3.disabled = true
		
func _on_continue_pressed() -> void:
	get_tree().root.get_node("Level/WaveManager").ContinuePressedInCardGenerator()
	$Card1.visible = false
	$Card2.visible = false
	$Card3.visible = false
	$Continue.visible = false
	get_tree().root.get_tree().paused = false
	get_parent().get_parent().get_node("Enemy").get_tree().paused = false
	

func _new_wave() -> void:
	print("ok")
	var x = RandomNumberGenerator.new()
	var y = RandomNumberGenerator.new()
	var z = RandomNumberGenerator.new()
	rx = x.randi_range(0, 7)
	ry = y.randi_range(0, 7)
	rz = z.randi_range(0, 7)
	
	$Card1.visible = true
	$Card2.visible = true
	$Card3.visible = true
	$Continue.visible = true
	
	$Card1.disabled = false
	$Card2.disabled = false
	$Card3.disabled = false
	
	get_tree().paused = true
	#get_parent().get_parent().print_tree_pretty()
	#get_parent().get_parent().get_node("Enemy").get_tree().paused = true
	
	$Card1.icon = load("res://cards/normal/card" + str(rx) + ".png")
	$Card1/Ability.text = get_parent().get_node("ActivationFunctions").get_child(rx).ability_text
	$Card1/Cost.text = get_parent().get_node("ActivationFunctions").get_child(rx).cost_text
	#$Card1/Ability.visible = true
	
	$Card2.icon = load("res://cards/normal/card" + str(ry) + ".png")
	$Card2/Ability.text = get_parent().get_node("ActivationFunctions").get_child(ry).ability_text
	$Card2/Cost.text = get_parent().get_node("ActivationFunctions").get_child(ry).cost_text
	#$Card2/Ability.visible = true
	
	$Card3.icon = load("res://cards/normal/card" + str(rz) + ".png")
	$Card3/Ability.text = get_parent().get_node("ActivationFunctions").get_child(rz).ability_text
	$Card3/Cost.text = get_parent().get_node("ActivationFunctions").get_child(rz).cost_text
	#$Card3/Ability.visible = true
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Cards"):
		_new_wave()
