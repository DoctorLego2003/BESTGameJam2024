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
		self.rotate(speed * delta)
	if moveRight:
		self.rotate(-speed * delta)
	
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
		var bullet = projectile.instantiate()
		get_parent().add_child(bullet)
		shoot_animation.play(&"shooting1")
		var smoke = bullet.get_parent().get_node("SmokeAnimation")
		smoke.global_position = bullet.global_position
		smoke.global_rotation = bullet.global_rotation
		smoke.play(&"smoke")
		
		hasBullet = false
		$Timer.start()

func _on_timer_timeout():
	hasBullet = true
