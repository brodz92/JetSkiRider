extends CharacterBody2D


const SPEED = 300.0
@onready var sprite = $Sprite2D



func _physics_process(delta):
	handleMovement()

func handleMovement():
	var xDirection = Input.get_axis("Left", "Right")
	var yDirection = Input.get_axis("Up", "Down")
	if xDirection or yDirection:
		velocity.x = xDirection * SPEED
		velocity.y = yDirection * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()

func handleAnimation():
	pass
