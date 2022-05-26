#try with the kinematicBody2d

extends Area2D

export var speedy = 500;
export var move_distance = 1000;

onready var start_pos = position.x
onready var end_pos = position.x + move_distance

func move_to(now, to, step):
	var new = now
	
	if new < to:
		new += step
		if new > to:
			new = to
	else:
		new -= step
		if new < to:
			new = to
	return new

func _physics_process(delta):
	
	position.x = move_to(position.x, end_pos, speedy * delta)

	if position.x == end_pos:
		$orosbux2.play("default")
		if end_pos == start_pos:
			end_pos = position.x + move_distance
			$orosbux2.flip_h = false
		else:
			end_pos = start_pos
			$orosbux2.flip_h = true

func _on_enemmy_body_entered(body):
	if body.name == "Player":
		body.damage(25)
