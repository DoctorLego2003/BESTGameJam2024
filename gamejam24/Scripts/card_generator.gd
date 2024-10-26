extends Control

var cards_directory = "res://cards/"
# This array will store loaded card textures
var card_images = []

func _process(delta: float) -> void:
	pass

func _ready() -> void:
	# Ensure all images in the directory are loaded at startup
	load_card_images()

func _on_card_1_pressed() -> void:
	# Select a random card texture and set it on the TextureButton
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	# Check if card_images is not empty
	if card_images.size() > 0:
		var random_index = rng.randi_range(0, card_images.size() - 1)
		var selected_card_texture = card_images[random_index]
		
		$Card1.icon = selected_card_texture
	else:
		print("Error: No card images loaded.")
	$Card1.visible = false
	

func _on_card_2_pressed() -> void:
	# Select a random card texture and set it on the TextureButton
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	# Check if card_images is not empty
	if card_images.size() > 0:
		var random_index = rng.randi_range(0, card_images.size() - 1)
		var selected_card_texture = card_images[random_index]
		
		$Card2.icon = selected_card_texture
	else:
		print("Error: No card images loaded.")
	$Card2.visible = false

func _on_card_3_pressed() -> void:
	# Select a random card texture and set it on the TextureButton
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	# Check if card_images is not empty
	if card_images.size() > 0:
		var random_index = rng.randi_range(0, card_images.size() - 1)
		var selected_card_texture = card_images[random_index]
		
		$Card3.icon = selected_card_texture
	else:
		print("Error: No card images loaded.")
	$Card3.visible = false
	


# Load all PNG images from the specified directory
func load_card_images() -> void:
	var dir = DirAccess.open(cards_directory)
	if dir:
		for file_name in dir.get_files():
			if file_name.ends_with(".png"):
				# Load the texture and add it to the card_images array
				var texture = load(cards_directory + "/" + file_name)
				card_images.append(texture)
	else:
		print("Error: Unable to open directory.")
	
	for i in range(1,4):
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		
		# Check if card_images is not empty
		if card_images.size() > 0:
			var random_index = rng.randi_range(0, card_images.size() - 1)
			var selected_card_texture = card_images[random_index]
			
			# Construct the dynamic node path and set the icon
			var card_node = get_node("Card" + str(i))
			if card_node:
				card_node.icon = selected_card_texture
			else:
				print("Error: Node 'Card" + str(i) + "' not found in the scene tree.")
