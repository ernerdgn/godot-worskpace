extends KinematicBody2D

const GRAVITY = 10
const SPEED = 70
const FLOOR = Vector2(0,-1)

signal hit

var velocity = Vector2()

var direct = 1  #1: right, -1: left

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.x = SPEED * direct
	if direct == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
	$AnimatedSprite.play("walk")
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)
	
	if is_on_wall():
		direct = direct * (-1)
