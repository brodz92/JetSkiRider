extends CharacterBody2D


const SPEED = 150.0
@onready var sprite = $Sprite2D
var xDirection
var yDirection



func _physics_process(delta):
	handleMovement()
	handleAnimation()

func handleMovement():
	xDirection = Input.get_axis("Left", "Right")
	yDirection = Input.get_axis("Up", "Down")
	if xDirection or yDirection:
		velocity.x = xDirection * SPEED
		velocity.y = yDirection * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()

func handleAnimation():
	if xDirection > 0:
		sprite.rotation_degrees = 90
	elif xDirection < 0:
		sprite.rotation_degrees = -90
	elif yDirection > 0:
		sprite.rotation_degrees = 180
	elif yDirection < 0:
		sprite.rotation_degrees = 0
