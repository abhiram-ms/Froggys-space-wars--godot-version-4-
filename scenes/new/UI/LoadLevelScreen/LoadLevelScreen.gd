extends Control

@onready var animation = $AnimationPlayer
var index=1
func _ready():
	$ColorRect.visible = false
#	$Sprite.visible = false
	animation.play("intro")

func _on_Button_pressed():
	if Global.currentLevel == 0:
		get_tree().change_scene_to_file("res://scenes/new/levels/level1/level1.tscn")
	else:
		index = SaveFile.gamedata.LevelsUnlocked
		var lvl_index  = str(Global.currentLevel)
		var path  = "res://scenes/new/levels/level"+lvl_index+"/level"+lvl_index+".tscn"
		get_tree().change_scene_to_file(path)


func _on_Back_pressed():
	get_tree().change_scene_to_file("res://scenes/new/UI/MainMenu/scene1.tscn")
