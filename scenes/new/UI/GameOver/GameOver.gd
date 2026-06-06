extends Control

@onready var gameover_text =  $VBoxContainer/GameOver
@onready var highscore_text = $VBoxContainer/HighScore
@onready var score_text = $VBoxContainer/Score
@onready var kills_text =$VBoxContainer/Kills
@onready var damage_text = $VBoxContainer/Damage

func _ready():
#	MobileAds.load_interstitial()
	#MobileAds.connect("interstitial_failed_to_load", Callable(self, "_on_MobileAds_interstitial_failed_to_load"))
	#MobileAds.connect("interstitial_failed_to_show", Callable(self, "_on_MobileAds_interstitial_failed_to_show"))
	Livescounter.connect("gameend", Callable(self, "_on_game_end"))

func _on_game_end():
	#MobileAds.load_interstitial()
	#MobileAds.show_interstitial()
	#print($background.visible)
	if(Livescounter.score_in_lvl >= Livescounter.score_to_win):
		gameover_text.text = "woohoo Won Level"
	else:
		gameover_text.text = "ooops Lost Level"
	
	highscore_text.text ="High Score : " + str(Livescounter.score_in_lvl)
	score_text.text ="Score : " + str(Livescounter.score_in_lvl)
	kills_text.text = "Kills : " + str(Livescounter.kills_in_lvl)
	damage_text.text = "Damage : " + str(Livescounter.damage_in_lvl)
	$AnimationPlayer.play("intro")

func _on_PlayAgain_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_Levels_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/new/UI/Levels/Levels.tscn")


func _on_Home_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/new/UI/MainMenu/scene1.tscn")

func _on_MobileAds_interstitial_failed_to_load(error_code):
	pass
func _on_MobileAds_interstitial_failed_to_show(error_code):
	pass
#	OS.alert(str(error_code),"failed to show ad")
