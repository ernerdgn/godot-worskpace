extends CanvasLayer
signal start_game
signal resume_game
signal exit_game
signal restart_game
signal ok_options
signal options_game
signal music_game(value)
signal sound_game(value)

#updating the related HUD and texts
func show_massage(text):
	$MSG.text = text
	$MSG.show()
	$MSGT.start()
func update_score(score):
	$ScoreLab.text = str(score)

#updating the health bar
func update_health(health):
	$ProgressBar.value = health

#for something really sexy... (for erasing the starting text "Episode-x")
func _on_MessageTimer_timeout():
	$MSG.hide() 

#get the start signal on menu
func _on_Start_pressed():
	emit_signal("start_game")

#get the options signal on menu
func _on_Options_pressed():
	emit_signal("options_game")

#get the exit signal on menu
func _on_Exit_pressed():
	emit_signal("exit_game")

#get the resume signal on menu
func _on_Resume_pressed():
	emit_signal("resume_game")

#get the restart signal on menu
func _on_Restart_pressed():
	emit_signal("restart_game")

#get the music ON/OFF signal on settings
func _on_Music_toggled(button_pressed):
	emit_signal("music_game", button_pressed)

#get the sound ON/OFF signal on settings
func _on_Sound_toggled(button_pressed):
	emit_signal("sound_game", button_pressed)

#get the "KAYDET" signal on settings...
func _on_Kaydet_pressed():
	emit_signal("ok_options")
