extends Control

@onready var score = $Scroll/Vbox/Score/Score
@onready var player_name = $Scroll/Vbox/Name/LineEdit
@onready var gamedata = SaveFile.gamedata

func _ready():
	print(gamedata)
	
	player_name.text = gamedata.PlayerName
	score.text = "%s" % [gamedata.HighScore]
#	$AnimationPlayer.play("intro")




func _on_LineEdit_text_changed(new_text):
	SaveFile.gamedata.PlayerName = new_text
	SaveFile.saveData()


func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/new/UI/MainMenu/scene1.tscn")


func _on_deleteData_pressed():
	SaveFile.deleteFile()
	get_tree().quit()



func _on_showData_pressed():
	SaveFile.show_saved_games()


func _on_Button_pressed():
	SaveFile.save_game()
