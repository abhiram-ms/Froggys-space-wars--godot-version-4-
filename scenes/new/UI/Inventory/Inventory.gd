extends Control

@onready var coins = $HBoxContainer/Label
@onready var gamedata = SaveFile.gamedata

func _ready() -> void:
	#MobileAds.connect("rewarded_ad_failed_to_load", Callable(self, "_on_MobileAds_rewarded_ad_failed_to_load"))
	#MobileAds.connect("rewarded_ad_failed_to_show", Callable(self, "_on_MobileAds_rewarded_ad_failed_to_show"))
	#MobileAds.connect("user_earned_rewarded", Callable(self, "_on_MobileAds_user_earned_rewarded"))
	#MobileAds.load_rewarded()
	coins.text = "Froggy Coins :" +str(gamedata.FroggyCoins)


func _physics_process(delta):
	coins.text = str(gamedata.FroggyCoins)

func _on_Back_pressed():
	get_tree().change_scene_to_file("res://scenes/new/UI/MainMenu/scene1.tscn")


func _on_Button_pressed():
	pass
	#MobileAds.show_rewarded()
	#MobileAds.load_rewarded()
	#OS.alert("Ad is not loaded","Ad")

func _on_MobileAds_user_earned_rewarded(currency : String, amount : int) -> void:
	gamedata.FroggyCoins += 50
	SaveFile.saveData()
	print("EARNED " + currency + " with amount: " + str(amount) + "\n")

func _on_MobileAds_rewarded_ad_failed_to_load(error_code):
#	OS.alert(str(error_code),"failed loading ad")
	pass
func _on_MobileAds_rewarded_ad_failed_to_show(error_code):
#	OS.alert(str(error_code),"failed to show ad")
	pass
