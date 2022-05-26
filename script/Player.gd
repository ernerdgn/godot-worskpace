extends KinematicBody2D

var main
var hit = false
var direction = 0
var Velocity = Vector2()
var i = 0  #for slowing down with the parachute
var on_ground = false
var jumper = 0  #jump count (for double jump)
var health = 100

export (float) var default_health = 100

const Speed:int = 400
const Gravity:int = 100
const Jump:int = 2000

onready var  die_madafaka
onready var HUD = get_node("NUD")
onready var Dead = get_node("Dead")
onready var Jumpp = get_node("Jumpp")
onready var Walk = get_node("Walk")
onready var Ninja = get_node("Ninja")
onready var invulnerability_timer = $invulnerabilityAfterHit


func _ready():
	main = get_tree().get_current_scene()

#this  function contains the main physics and actions
func _process(_delta):
	#Strength=Zorlama iki tuşa aynı anda basılmamasını sağlar. 
	direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if Input.is_action_just_pressed("jump_madafaka"):
#==================following codes are for single jump=========================#
#		if on_ground == true:
#			Velocity.y -= Jump
#			jumper += 1
#	if jumper == 1:
#		if Input.is_action_just_pressed("jump_madafaka"):
#			Velocity.y -= Jump
#			jumper += 1

#==================following three lines are for double-jump===================#
		if jumper < 2:
			jumper += 1
			Velocity.y -= Jump
		
	Velocity.y += Gravity
	
	Velocity.x = direction * Speed
	
	if position.y > 5000:
		get_tree().reload_current_scene()
	
	Velocity = move_and_slide(Velocity, Vector2.UP)
	update_animation ()
	
#the following 7 lines are for slowing down with the parachute
	if Input.is_action_pressed("parachute"):
		i = 1
		while i > 0:
			Velocity.y = Gravity - 50
			if is_on_floor():
				i = i * (-1)
			break;

#this function is all about the appearance of the player in certain actions
func update_animation():

#========================= DEAD ANIMATIONS ====================================#
	if is_on_floor():
		
		if default_health == 0:
			Ninja.play("Dead")
			if Ninja.frame == 7 :
				var dead = get_tree().reload_current_scene()
			else:
					return

		on_ground = true
		jumper = 0
#======================== WALK ANIMATIONS =====================================#
		if direction == 1:   #if Input.action_pressed("ui_right"):
			Ninja.flip_h = false
			if not Walk.playing:
				Walk.play()
			Ninja.play("Walk")
			
		elif direction == -1:  #elif Input.action_pressed("ui_left"):
			Ninja.flip_h = true
			if not Walk.playing:
				Walk.play()
			Ninja.play("Walk")
		else:
			Ninja.play("Idle")  #when the ninja stops, loop Idle animation
#======================== JUMP ANIMATIONS =====================================#
	else:
		Ninja.play("Jump")
		if direction == 1:
			Ninja.flip_h = false
			
		elif direction == -1:
			Ninja.flip_h = true
			
			
		if Input.is_action_pressed("jump_madafaka"):
			if on_ground == true:
				if not Jumpp.playing:
					on_ground = false
					Jumpp.play()
					Ninja.play("Jump")

		if Input.is_action_pressed("parachute"):
			Ninja.play("Fall")

#======================== TAKING DAMAGE AND DYING =============================#
func damage(amount):  #will be changed due to the enemy types
		_set_health(health - amount)
		$AnimationPlayer.play("Hit")

func die_madafaka():  #death function / just returning the main menu for now
	Ninja.play("Dead")
	get_tree().reload_current_scene()

func _set_health(value):
		var previous_health = health
		health = clamp(value, 0, default_health)  #sets the health between 0-100
		if health != previous_health:
			main.get_node("HUD").update_health(health)

		if health == 0:
			die_madafaka()
