extends Control


func changeLevel(path:String):
	get_tree().change_scene_to_file(path)
	
#
func _on_BackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/new/UI/MainMenu/scene1.tscn")
