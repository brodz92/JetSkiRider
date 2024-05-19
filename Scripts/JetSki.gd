extends CharacterBody2D


const SPEED = 300
@onready var sprite = $Sprite2D

var xDirection
var yDirection

func _ready():
	SignalBus.playerJumpSmall.connect(on_playerJumpSmall)

func on_playerJumpSmall():
	jumpUp()
	jumpDown()

func jumpUp():
	var tween = create_tween()
	tween.tween_property($Sprite2D ,"scale", Vector2(3,3), 0.5)

func jumpDown():
	var tween = create_tween()
	tween.tween_property($Sprite2D ,"scale", Vector2(1,1), 0.5)

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
