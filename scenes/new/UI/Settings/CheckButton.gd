extends CheckButton

func _on_music_button_toggled(toggled_on: bool):
	BackgroundMusic.playing = toggled_on
