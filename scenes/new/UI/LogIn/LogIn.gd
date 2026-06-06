extends Control


@onready var animation = $AnimationPlayer

var GPGS;

func _ready():
	if PlayService.GPGS:
		PlayService.GPGS.connect("_on_sign_in_success", Callable(self, "_on_sign_in_success"))
		PlayService.GPGS.connect("_on_sign_in_failed", Callable(self, "_on_sign_in_failed"))
		
		##game data save
#		PlayService.GPGS.connect("_on_game_saved_success",self,"_on_game_saved_success")
#		PlayService.GPGS.connect("_on_game_saved_fail",self,"_on_game_saved_fail")
#		PlayService.GPGS.connect("_on_game_load_success",self,"_on_game_load_success")
#		PlayService.GPGS.connect("_on_game_load_fail",self,"_on_game_load_fail")
#		PlayService.GPGS.connect("_on_create_new_snapshot",self,"_on_create_new_snapshot")
		
	if PlayService.single:
		OS.alert("Error in play games services")
	animation.play("intro")


func _on_LogIn_pressed():
#	get_tree().change_scene("res://scenes/new/UI/MainMenu/scene1.tscn")
	if PlayService.GPGS:
		PlayService.GPGS.signIn()
#	else:
#		get_tree().change_scene("res://scenes/new/UI/MainMenu/scene1.tscn")
#	if GPGS:
#		GPGS.signIn()

func loadGame():
	if PlayService.GPGS:
		PlayService.GPGS.loadSnapshot("gamedata")

func _on_sign_in_success(userInformation):
#	OS.alert("success"+ userInformation)
	SaveFile.loadData()
	get_tree().change_scene_to_file("res://scenes/new/UI/MainMenu/scene1.tscn")
	
func _on_sign_in_failed(errorCode:int):
	OS.alert("failed cant connect to sign in")



##play games services callbacks from connect
func _on_game_saved_success():
	OS.alert("GAME SAVED SUCCESS")

func _on_game_saved_fail():
	OS.alert("Game saved fail")

func _on_game_load_success(data):
	OS.alert("load success")
	var test_json_conv = JSON.new()
	test_json_conv.parse(data)
	var testData = test_json_conv.get_data()
	
	if testData == null:
		SaveFile.gamedata = SaveFile.initialData
		SaveFile.saveData()
	else:
		SaveFile.gamedata = testData
		SaveFile.saveData()
	
	OS.alert(data + "===="+ SaveFile.gamedata)

func _on_game_load_fail():
	OS.alert("Game data loading failed")

func _on_create_new_snapshot(name:String):
	OS.alert("Create new snapshot %s"%name)

##game save metheods:
func save_game() -> void:
	if PlayService.GPGS:
		var data_to_save: Dictionary = {
		"name": "John", 
		"age": 22,
		"height": 1.82,
		"is_gamer": true
		}
		PlayService.GPGS.saveSnapshot("john", JSON.new().stringify(data_to_save), "DESCRIPTION")
	else:
		OS.alert("no play services aces to load data")
