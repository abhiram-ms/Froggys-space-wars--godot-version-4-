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
	if _has_gpgs():
		_connect_gpgs_signals()
	else:
		print("Play service is not configured. SaveFile will use local saves only.")

	# Load local data immediately so menus/game scenes have valid data even
	# when Google Play Services is not installed yet.
	load_local_data()


func _has_gpgs() -> bool:
	return PlayService != null and PlayService.GPGS != null


func _connect_gpgs_signals() -> void:
	var signals_to_connect := {
		"_on_game_saved_success": Callable(self, "_on_game_saved_success"),
		"_on_game_saved_fail": Callable(self, "_on_game_saved_fail"),
		"_on_game_load_success": Callable(self, "_on_game_load_success"),
		"_on_game_load_fail": Callable(self, "_on_game_load_fail"),
		"_on_create_new_snapshot": Callable(self, "_on_create_new_snapshot"),
	}

	for signal_name in signals_to_connect.keys():
		if PlayService.GPGS.has_signal(signal_name) and not PlayService.GPGS.is_connected(signal_name, signals_to_connect[signal_name]):
			PlayService.GPGS.connect(signal_name, signals_to_connect[signal_name])
		else:
			print("GPGS signal not available or already connected: %s" % signal_name)


# =========================
# SAVE DATA
# =========================
func save_data(sync_cloud := true) -> void:
	if gamedata.is_empty():
		gamedata = initial_data.duplicate(true)

	var file := FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	if file == null:
		push_error("Failed to open save file")
		return

	file.store_var(gamedata)
	file.close()
	print("Local save completed")

	if sync_cloud:
		save_game()


# Backward-compatible Godot 3 style method name used by some older scripts.
func saveData() -> void:
	save_data()


# =========================
# LOAD DATA
# =========================
func load_data() -> void:
	# Local-first behavior: always load/create local save immediately.
	load_local_data()

	# Future GPGS behavior: when a compatible plugin exists, this can refresh
	# local data from cloud. The game no longer depends on cloud loading to run.
	if _has_gpgs():
		load_play_store_data()


# Backward-compatible Godot 3 style method name used by older scripts.
func loadData() -> void:
	load_data()


func load_local_data() -> void:
	if FileAccess.file_exists(SAVE_FILE):
		var file := FileAccess.open(SAVE_FILE, FileAccess.READ)
		if file == null:
			push_error("Failed to read local save file. Loading initial data instead.")
			gamedata = initial_data.duplicate(true)
			return

		var loaded_data = file.get_var()
		file.close()

		if loaded_data is Dictionary:
			gamedata = _merge_with_initial_data(loaded_data)
			print("Local save loaded")
		else:
			push_error("Local save data is invalid. Creating new save data.")
			gamedata = initial_data.duplicate(true)
			save_data(false)
	else:
		print("No local save found. Creating initial save data.")
		gamedata = initial_data.duplicate(true)
		save_data(false)


func _merge_with_initial_data(loaded_data: Dictionary) -> Dictionary:
	var merged_data := initial_data.duplicate(true)
	for key in loaded_data.keys():
		merged_data[key] = loaded_data[key]
	return merged_data


# =========================
# PLAY STORE LOAD
# =========================
func load_play_store_data() -> void:
	if _has_gpgs() and PlayService.GPGS.has_method("loadSnapshot"):
		PlayService.GPGS.loadSnapshot("gamedata")
	else:
		print("No Google Play cloud save available. Using local save.")


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
		gamedata = initial_data.duplicate(true)
		save_data(false)
	else:
		push_error("Failed to delete file")


# =========================
# GOOGLE PLAY SAVE
# =========================
func save_game() -> void:
	if _has_gpgs() and PlayService.GPGS.has_method("saveSnapshot"):
		PlayService.GPGS.saveSnapshot(
			"gamedata",
			JSON.stringify(gamedata),
			"Highscore " + str(gamedata.get("HighScore", 0))
		)
	else:
		# This is expected while the project is running without a GPGS plugin.
		print("Google Play cloud save unavailable. Local save kept.")


func show_saved_games() -> void:
	if _has_gpgs() and PlayService.GPGS.has_method("showSavedGames"):
		PlayService.GPGS.showSavedGames(
			"gamedata",
			true,
			true,
			5
		)
	else:
		print("Google Play saved games UI unavailable.")


func load_game() -> void:
	load_data()


# Backward-compatible Godot 3 style method name.
func loadGame() -> void:
	load_game()


# =========================
# CALLBACKS
# =========================
func _on_game_saved_success() -> void:
	print("Game saved successfully to cloud")


func _on_game_saved_fail() -> void:
	push_error("Game cloud saving failed. Local save is still available.")


func _on_game_load_success(data) -> void:
	print("Cloud save load success")
	var received_data = JSON.parse_string(data)
	if received_data == null:
		print("No cloud save found. Keeping local save data.")
		if gamedata.is_empty():
			gamedata = initial_data.duplicate(true)
			save_data(false)
	else:
		print("Cloud save loaded. Updating local save.")
		gamedata = _merge_with_initial_data(received_data)
		save_data(false)


func _on_game_load_fail() -> void:
	push_error("Cannot connect to cloud save. Using local save data.")
	load_local_data()


@warning_ignore("shadowed_variable_base_class")
func _on_create_new_snapshot(name: String) -> void:
	print("Create new snapshot: %s" % name)
