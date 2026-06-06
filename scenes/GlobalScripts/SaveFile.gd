extends Node2D

const SAVE_FILE := "user://save_file.save"
var ignore := "Madfroggy#0"
var gamedata: Dictionary = {}

var initial_data: Dictionary = {
	"PlayerName": "MadFroggy #",
	"HighScore": 0,
	"LevelsUnlocked": 1,
	"PlayersUnlocked": 1,
	"CurrentLevel": 1,
	"CurrentPlayer": 1,
	"FroggyCoins": 100,
	"TopKills": 0,
	"SpaceShipUnlocked": [1],
	"SpaceShipCurrent": 1,
	"BulletsUnlocked": [1],
	"BulletsCurrent": 1,
}

var test_data: Dictionary = {
	"PlayerName": "MadFroggy #",
	"HighScore": 500,
	"LevelsUnlocked": 1,
	"PlayersUnlocked": 1,
	"CurrentLevel": 1,
	"CurrentPlayer": 1,
	"FroggyCoins": 100,
	"TopKills": 0,
	"SpaceShipUnlocked": [1],
	"SpaceShipCurrent": 1,
	"BulletsUnlocked": [1],
	"BulletsCurrent": 1,
}


func _ready() -> void:
	if PlayService.GPGS:
		PlayService.GPGS.connect(
			"_on_game_saved_success",
			Callable(self, "_on_game_saved_success")
		)

		PlayService.GPGS.connect(
			"_on_game_saved_fail",
			Callable(self, "_on_game_saved_fail")
		)

		PlayService.GPGS.connect(
			"_on_game_load_success",
			Callable(self, "_on_game_load_success")
		)

		PlayService.GPGS.connect(
			"_on_game_load_fail",
			Callable(self, "_on_game_load_fail")
		)

		PlayService.GPGS.connect(
			"_on_create_new_snapshot",
			Callable(self, "_on_create_new_snapshot")
		)

	else:
		push_error("Play service is not configured to store data")

	# load local/mobile data
	# load_data()


# =========================
# SAVE DATA
# =========================
func save_data() -> void:
	var file := FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	if file == null:
		push_error("Failed to open save file")
		return
	file.store_var(gamedata)
	file.close()
	save_game()


# =========================
# LOAD DATA
# =========================
func load_data() -> void:
	# Optional local save loading:
	#
	# if FileAccess.file_exists(SAVE_FILE):
	# 	var file := FileAccess.open(SAVE_FILE, FileAccess.READ)
	# 	if file:
	# 		gamedata = file.get_var()
	# 		file.close()
	# else:
	# 	load_play_store_data()
	load_play_store_data()


# =========================
# PLAY STORE LOAD
# =========================
func load_play_store_data() -> void:
	if PlayService.GPGS:
		PlayService.GPGS.loadSnapshot("gamedata")
	else:
		push_error("No play service access to load data")


# =========================
# DELETE SAVE FILE
# =========================
func delete_file() -> void:
	if !FileAccess.file_exists(SAVE_FILE):
		print("No file to delete")
		return
	var err := DirAccess.remove_absolute(SAVE_FILE)
	if err == OK:
		print("File deleted")
	else:
		push_error("Failed to delete file")


# =========================
# GOOGLE PLAY SAVE
# =========================
func save_game() -> void:
	if PlayService.GPGS:
		PlayService.GPGS.saveSnapshot(
			"gamedata",
			JSON.stringify(gamedata),
			"Highscore " + str(gamedata["HighScore"])
		)
	else:
		push_error("No play services access to save data")


func show_saved_games() -> void:
	if PlayService.GPGS:
		PlayService.GPGS.showSavedGames(
			"gamedata",
			true,
			true,
			5
		)


func load_game() -> void:
	if PlayService.GPGS:
		PlayService.GPGS.loadSnapshot("gamedata")


# =========================
# CALLBACKS
# =========================
func _on_game_saved_success() -> void:
	print("Game saved successfully")


func _on_game_saved_fail() -> void:
	push_error("Game saving failed")


func _on_game_load_success(data) -> void:
	print("Load success")
	var received_data = JSON.parse_string(data)
	if received_data == null:
		print("No cloud save found, creating initial data")
		gamedata = initial_data.duplicate(true)
		save_data()

	else:
		print("Cloud save loaded")
		gamedata = received_data
		save_data()


func _on_game_load_fail() -> void:
	push_error("Cannot connect to saved server data")
	gamedata = initial_data.duplicate(true)
	save_data()


@warning_ignore("shadowed_variable_base_class")
func _on_create_new_snapshot(name: String) -> void:
	print("Create new snapshot: %s" % name)
