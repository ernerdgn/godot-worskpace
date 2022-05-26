extends Node2D

var score = 0
var health = 100

#calls the related HUD and texts
func _ready():
	Global.game_over = false
	if get_tree().get_current_scene().name == "Episode-1":
		get_tree().paused = true
	else:
		$HUD/Menu1.hide()
		$HUD.show_massage(self.name)

#calling the pause menu
func _process(_delta):
	if Input.is_action_just_pressed("pausing"):
		get_tree().paused = true
		$HUD/Menu2.show()
	if get_tree().paused == true:
		$HUD/Menu1.hide()
		$HUD.show_massage(get_tree().get_current_scene().get_name())

#calling the game to start
func _on_HUD_start_game():
	$HUD/Menu1.hide()
	Global.game_over = false
	$HUD.show_massage(self.name)
	get_tree().paused=false

#calling the options menu
func _on_HUD_options_game():
	$HUD/Menu3.show()

#exitting game
func _on_HUD_exit_game():
	get_tree().quit()

#calling the game to continue
func _on_HUD_resume_game():
	$HUD/Menu2.hide()
	get_tree().paused =false

#calling the game to restart
func _on_HUD_restart_game():
	$HUD/Menu2.hide()
	var _error = get_tree().change_scene("res://scene/World .tscn")

#in options, closing the music
func _on_HUD_music_game(value):
	Global.music_mute = not value
	var idx = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(idx,Global.music_mute)

#in options, closing the sounds
func _on_HUD_sound_game(value):
	Global.music_mute = not value
	var idx = AudioServer.get_bus_index("FX")
	AudioServer.set_bus_mute(idx,Global.music_mute)

#save the options
func _on_HUD_ok_options():
	$HUD/Menu3.hide()
