extends Node

var GPGS = null
var single := false
var cloud_save_enabled := false

func _ready() -> void:
	if Engine.has_singleton("GodotPlayGamesServices"):
		GPGS = Engine.get_singleton("GodotPlayGamesServices")
		single = false
		cloud_save_enabled = true

		# Future GPGS support: keep this old plugin init call, but only call it
		# when the plugin exists and exposes the method.
		if GPGS.has_method("initWithSavedGames"):
			GPGS.initWithSavedGames(true, "gamename", false, false, "")
		else:
			print("GPGS plugin found, but initWithSavedGames() is not available")
	else:
		GPGS = null
		single = true
		cloud_save_enabled = false
		print("Google Play Services plugin not found. Running with local saves only.")

func is_available() -> bool:
	return GPGS != null

func can_use_cloud_save() -> bool:
	return GPGS != null and cloud_save_enabled
