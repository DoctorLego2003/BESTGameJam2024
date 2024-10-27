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
	# Ensure all images in the directory are loaded at startup
	#load_card_images()
	_new_wave()
	get_tree().root.print_tree_pretty()
	#pass


func _on_card_1_pressed() -> void:
	get_parent().get_node("ActivationFunctions").get_child(rx).activate()
	#$Card1.visible = false
	$Card1.icon = load("res://cards/hidden/card" + str(rx) + ".png")
	$Card1.disabled = true
	

func _on_card_2_pressed() -> void:
	get_parent().get_node("ActivationFunctions").get_child(ry).activate()
	#$Card2.visible = false
	$Card2.icon = load("res://cards/hidden/card" + str(ry) + ".png")
	$Card2.disabled = true

func _on_card_3_pressed() -> void:
	get_parent().get_node("ActivationFunctions").get_child(rz).activate()
	#$Card3.visible = false
	$Card3.icon = load("res://cards/hidden/card" + str(rz) + ".png")
	$Card3.disabled = true


func _on_continue_pressed() -> void:
	$Card1.visible = false
	$Card2.visible = false
	$Card3.visible = false
	$Continue.visible = false
	get_tree().paused = false
	get_parent().get_parent().get_node("Enemy").get_tree().paused = false
	

func _new_wave() -> void:
	var x = RandomNumberGenerator.new()
	var y = RandomNumberGenerator.new()
	var z = RandomNumberGenerator.new()
	rx = x.randi_range(0, 5)
	ry = y.randi_range(0, 5)
	rz = z.randi_range(0, 5)
	
	$Card1.visible = true
	$Card2.visible = true
	$Card3.visible = true
	$Continue.visible = true
	
	$Card1.disabled = false
	$Card2.disabled = false
	$Card3.disabled = false
	
	get_tree().paused = true
	get_parent().get_parent().print_tree_pretty()
	get_parent().get_parent().get_node("Enemy").get_tree().paused = true
	
	$Card1.icon = load("res://cards/normal/card" + str(rx) + ".png")
	$Card2.icon = load("res://cards/normal/card" + str(ry) + ".png")
	$Card3.icon = load("res://cards/normal/card" + str(rz) + ".png")
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Cards"):
		_new_wave()
