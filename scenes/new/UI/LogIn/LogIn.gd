extends Control

@onready var animation = $AnimationPlayer

var GPGS = null

func _ready():
	if PlayService.GPGS:
		if PlayService.GPGS.has_signal("_on_sign_in_success"):
			PlayService.GPGS.connect("_on_sign_in_success", Callable(self, "_on_sign_in_success"))
		if PlayService.GPGS.has_signal("_on_sign_in_failed"):
			PlayService.GPGS.connect("_on_sign_in_failed", Callable(self, "_on_sign_in_failed"))
	else:
		print("Google Play Services unavailable. Login will continue with local save.")

	animation.play("intro")


func _on_LogIn_pressed():
	if PlayService.GPGS and PlayService.GPGS.has_method("signIn"):
		PlayService.GPGS.signIn()
	else:
		_start_game_with_local_save()


func _start_game_with_local_save() -> void:
	SaveFile.load_data()
	get_tree().change_scene_to_file("res://scenes/new/UI/MainMenu/scene1.tscn")


func loadGame():
	SaveFile.load_data()


func _on_sign_in_success(userInformation):
	SaveFile.load_data()
	get_tree().change_scene_to_file("res://scenes/new/UI/MainMenu/scene1.tscn")
	
func _on_sign_in_failed(errorCode:int):
	push_error("Google Play sign in failed. Continuing with local save.")
	_start_game_with_local_save()


## Play Games Services callbacks kept for future GPGS compatibility.
func _on_game_saved_success():
	print("GAME SAVED SUCCESS")

func _on_game_saved_fail():
	push_error("Game cloud save failed")

func _on_game_load_success(data):
	print("Cloud load success")
	var testData = JSON.parse_string(data)
	
	if testData == null:
		SaveFile.gamedata = SaveFile.initial_data.duplicate(true)
		SaveFile.save_data(false)
	else:
		SaveFile.gamedata = testData
		SaveFile.save_data(false)

func _on_game_load_fail():
	push_error("Game cloud data loading failed. Using local save.")
	SaveFile.load_local_data()

func _on_create_new_snapshot(name:String):
	print("Create new snapshot %s" % name)

## Game save method kept for future GPGS compatibility.
func save_game() -> void:
	SaveFile.save_data()
