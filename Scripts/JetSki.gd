extends CharacterBody2D


const SPEED = 300
@onready var sprite = $Sprite2D
@onready var jet_ski = $"."
@onready var collision = $CollisionShape2D
@onready var timer: Timer = $Timer
var acceleration = 400
var max_speed = 300
var friction = 100
var angular_speed = 4
#var velocity = Vector2.ZERO

var xDirection
var yDirection

func _ready():
	SignalBus.playerJumpSmall.connect(on_playerJumpSmall)
	SignalBus.speedPowerUp.connect(on_speedPowerUp)
	#var velocity = Vector2.ZERO

func on_playerJumpSmall():
	jumpUp()

func on_speedPowerUp():
	acceleration = 900
	max_speed = 600
	timer.start()

func jumpUp():
	var tween = create_tween()
	tween.tween_property(collision ,"disabled", true, 0)
	tween.parallel().tween_property(jet_ski ,"scale", Vector2(1.5,1.5), 0.3)
	tween.tween_property(jet_ski ,"scale", Vector2(0.5,0.5), 0.3)
	tween.tween_property(collision ,"disabled", false, 0)

func _physics_process(delta):
	handle_movement(delta)
	#handleAnimation()


func handle_movement(delta):
	var input_direction = Vector2.ZERO
	# Handle movement
	if Input.is_action_pressed("Up"):
		input_direction = Vector2.UP.rotated(rotation)

	if input_direction != Vector2.ZERO:
		input_direction = input_direction.normalized()
		velocity += input_direction * acceleration * delta
		if velocity.length() > max_speed:
			velocity = velocity.normalized() * max_speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	move_and_slide()

	# Handle rotation input
	var x_direction = Input.get_axis("Left", "Right")
	if x_direction != 0:
		rotation_degrees += x_direction * angular_speed
	if Input.is_action_pressed("Down"):
		var currentFriction = friction
		friction += 50
		if Input.is_action_just_released("Down"):
			friction = currentFriction


func _on_timer_timeout() -> void:
	acceleration = 400
	max_speed = 300
