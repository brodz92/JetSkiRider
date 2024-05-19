extends CharacterBody2D


const SPEED = 300
@onready var sprite = $Sprite2D
@onready var jump_timer = $JumpTimer

var xDirection
var yDirection
var currentScale = scale

func _ready():
	SignalBus.playerJumpSmall.connect(on_playerJumpSmall)

func on_playerJumpSmall():
	var newScale = currentScale + 3
	jump_timer.start()

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

func _on_jump_timer_timeout():
	scale = currentScale
