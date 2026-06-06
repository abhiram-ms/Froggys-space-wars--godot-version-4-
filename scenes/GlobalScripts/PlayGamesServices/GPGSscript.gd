extends Node

var GPGS;
var single = false

func _ready():
	if Engine.has_singleton("GodotPlayGamesServices"):
		GPGS = Engine.get_singleton("GodotPlayGamesServices")
		GPGS.initWithSavedGames(true, "gamename",false, false, "")
	else:
		print("no singleton")
		single = true
#	pass


