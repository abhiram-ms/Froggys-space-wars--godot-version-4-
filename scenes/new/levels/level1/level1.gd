extends Node2D

var rng = RandomNumberGenerator.new()

#var frog1 = preload("res://scenes/new/character/Frog1/Frog1.tscn")
#var frog2 = preload("res://scenes/new/character/Frog2/Frog2.tscn")

@onready var pathfollow2d = $CanvasLayer/Path2D/PathFollow2D
@onready var positionplayer = $CanvasLayer/Path2D/PathFollow2D/Positionplayer
#onready var enemyTimer = $enemy_timer
@onready var objectTimer = $ObjectS_Timer
@onready var healthTimer = $HealthCollectibleTimer
@onready var gamedata = SaveFile.gamedata
#onready var playertimer = $PlayerTimer

@export var kills_required: int;
@export var enemy_number: int;
@export var bullet_amount: int;
@export var enemy_shooting_time: int;
@export var lvl_index: int;
@export var enemy_timer: float;
@export var objects_timer: int;
@export var health_timer: int;
@export var LevelName: String;

func _ready():
#	OS.alert(str(SaveFile.gamedata.SpaceShipCurrent))
#	OS.alert("changing scene")
#	#ad
	#MobileAds.load_interstitial()
	changeUpdateLevel()
	setLivesCounter()
	addPlayer()
	setUiBars()
	

func setTimers():
#	enemyTimer.wait_time = enemy_timer
	objectTimer.wait_time = objects_timer
	healthTimer.wait_time = health_timer

func addPlayer():
	if str(SaveFile.gamedata.SpaceShipCurrent) != "Null":
		var player = Global.SpaceShips[SaveFile.gamedata.SpaceShipCurrent -1]
		var player_instance = player.instance()
		call_deferred("add_child", player_instance)
	else:
		var player = Global.SpaceShips[0]
		var player_instance = player.instance()
		call_deferred("add_child", player_instance)
#	var player_instance = frog1.instance()
#	add_child(player_instance)
#	var player = SaveFile.gamedata.SpaceShipCurrent
#	var player_instance;
#	if player == 1:
#		player_instance = frog1.instance()
#	elif player == 2:
#		player_instance = frog2.instance()
#	else:
#		player_instance = frog1.instance()
#	call_deferred("add_child", player_instance)


func changeUpdateLevel():
	if gamedata.LevelsUnlocked == lvl_index:
		Livescounter.update_lvl = true

func setLivesCounter():
	Livescounter.kills_required = self.kills_required
	Livescounter.enemy_number = self.enemy_number
	Livescounter.bullet_amount = self.bullet_amount

func setUiBars():
	get_node("CanvasLayer/Progress/ProgressBar/BulletContainer/bullets").max_value = self.bullet_amount
	get_node("CanvasLayer/Progress/ProgressBar/KillContainer/kills").max_value = self.kills_required


func _on_ObjectS_Timer_timeout():
	addObjects(Global.blackhole.instantiate())

func _on_CollectibleTimer_timeout():
	addObjects(Global.health.instantiate())

func _on_BulletsTimer_timeout():
	addObjects(Global.Collectbullets.instantiate())

func addObjects(objectInstance):
	# Get view rectangle
#	var ctrans = get_canvas_transform()
#	var min_pos = -ctrans.get_origin() / ctrans.get_scale()
#	var view_size = get_viewport_rect().size / ctrans.get_scale()
#	var max_pos = min_pos + view_size
	var cameraposition = Global.camera.global_position
#	var screenSize = get_viewport().get_visible_rect().size
	var rndX = rng.randi_range(cameraposition.x - 1024, cameraposition.x)
	var rndY = rng.randi_range(cameraposition.y - 720, cameraposition.y)
	
	
	var instance = objectInstance
	instance.global_position = Vector2(rndX,rndY)
	add_child(instance)




func _on_PlayerTimer_timeout():
	pass
