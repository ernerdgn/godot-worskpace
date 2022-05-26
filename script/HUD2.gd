extends CanvasLayer



func _ready():
	pass 
	
func show_massage(text):
	$Msg2.text = text
	$Msg2.show()
	$Timer.start()
func update_score(score):
	$SCR.text = str(score)

func _on_Timer_timeout():
	$Msg2.hide()
