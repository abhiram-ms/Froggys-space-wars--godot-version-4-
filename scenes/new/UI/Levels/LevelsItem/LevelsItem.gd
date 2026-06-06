extends TextureButton

@export var index: int = 1;
#export(Texture) var enabled;
#export(Texture) var disabled_image;

func _ready():
	if index <= SaveFile.gamedata.LevelsUnlocked:
		modulate.a8 = 255
		disabled = false
	else:
		modulate.a8 = 130
		disabled = true


func _on_LevelsItem_pressed():
	Global.currentLevel = index
	get_tree().change_scene_to_file("res://scenes/new/UI/LoadLevelScreen/LoadLevelScreen.tscn")
	

