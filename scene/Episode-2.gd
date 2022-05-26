extends Node2D

var score = 0

func _ready():
	$HUD2.show_massage(get_tree().get_current_scene().get_name())
