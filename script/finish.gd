extends Area2D

onready var main = get_tree().get_current_scene()

#final coin of the episode-1
func _on_Coin_body_entered(body):
	if body.name == "Player":
		if main.score == 3:
			$AnimationPlayer.play("hit")
		else :
			$AnimationPlayer.play("Red")

func _on_AnimationPlayer_animation_finished(anim_name):
	if main.score == 3:
		queue_free()
		get_tree().change_scene("res://scene/Episode-2.tscn")
	
