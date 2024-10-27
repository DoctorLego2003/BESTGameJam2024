extends Node2D
var moveLeft = false
var moveRight = false
var hasBullet = true
@export var speed = 3
var projectile = load("res://projectile.tscn")
@onready var shoot_animation = get_node("Player/PlayerArea/AnimatedSprite2D")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if moveLeft:
		var current_speed = speed * get_tree().root.get_node("Level/ModManager").PlayerSpeedMod
		self.rotate(current_speed * delta)
	if moveRight:
		var current_speed = speed * get_tree().root.get_node("Level/ModManager").PlayerSpeedMod
		self.rotate(-current_speed * delta)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("clockwise-move"):
		moveLeft = true
	elif event.is_action_released("clockwise-move"):
		moveLeft = false
	if event.is_action_pressed("anticlockwise-move"):
		moveRight = true
	elif event.is_action_released("anticlockwise-move"):
		moveRight = false
	if event.is_action_pressed("shoot") and hasBullet:
		for i in range(get_tree().root.get_node("Level/ModManager").BurstMod):
			_burst()
			await get_tree().create_timer(0.1).timeout
		
		$Timer.start()
		$Timer.wait_time = get_tree().root.get_node("Level/ModManager").CooldownMod

func _on_timer_timeout():
	hasBullet = true

func _burst():
	var current_projectile = projectile.instantiate()
	current_projectile.speed = 250 * get_tree().root.get_node("Level/ModManager").ProjectileSpeedMod
	get_parent().add_child(current_projectile)
	shoot_animation.play(&"shooting1")
	var smoke = get_parent().get_node("SmokeAnimation")
	smoke.global_position = current_projectile.get_node("Area2D").global_position
	smoke.global_rotation = current_projectile.get_node("Area2D").global_rotation
	smoke.play(&"smoke")
	hasBullet = false
