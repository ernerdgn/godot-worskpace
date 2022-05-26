extends Area2D

onready var main = get_tree().get_current_scene()

#========================= PICKING UP THE COINS ===============================#
func _on_Coin_body_entered(body):
	main.score += 1
	main.get_node("HUD").update_score(main.score)
	$AnimationPlayer.play("hit")


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
