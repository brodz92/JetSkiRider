extends CharacterBody2D


const SPEED = 300
@onready var sprite = $Sprite2D

var xDirection
var yDirection

func _ready():
	SignalBus.playerJumpSmall.connect(on_playerJumpSmall)

func on_playerJumpSmall():
	pass

func _physics_process(delta):
	handleMovement()
	#handleAnimation()


func handleMovement():
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("Up"):
		direction = Vector2.UP.rotated(rotation)
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
	
	xDirection = Input.get_axis("Left", "Right")
	if xDirection > 0:
		rotation_degrees += 3
	elif xDirection < 0:
		rotation_degrees -= 3
#func handleMovement():
	#
	#yDirection = Input.get_axis("Up", "Down")
	#if xDirection or yDirection:
		#velocity.x = xDirection * SPEED
		#velocity.y = yDirection * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.y = move_toward(velocity.y, 0, SPEED)
	#move_and_slide()

#func handleAnimation():
	#if xDirection > 0:
		#sprite.rotation_degrees = 90
	#elif xDirection < 0:
		#sprite.rotation_degrees = -90
	#elif yDirection > 0:
		#sprite.rotation_degrees = 180
	#elif yDirection < 0:
		#sprite.rotation_degrees = 0
