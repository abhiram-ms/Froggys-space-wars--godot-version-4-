extends Node

var lives  = 100
#var enemy_count = 0
var enemy_number = 10
var kills = 0
var bullet_amount = 250
var kills_required = 20
var highest_score = 100
var score_to_win = 5000
var is_level_won = false 

var kills_in_lvl
var damage_in_lvl
var score_in_lvl

var froggy_coins = 0
var update_lvl = false

signal gameend
@onready var gamedata = SaveFile.gamedata


func _ready():
	loadValues()
	loadScoreCard()

func _physics_process(delta):
	if kills == kills_required:
		#setting scorecard
		setScoreCard()
		Global.player.kill()
		emit_signal("gameend")
		updateGameValues()
		resetValues()
		print("win by kills")
	if is_level_won == true:
		#setting scorecard
		setScoreCard()
		Global.player.kill()
		emit_signal("gameend")
		updateGameValues()
		resetValues()
		updateLevel()
		print("win by planet enter")
		
	if lives == 80:
		pass
	if lives == 60:
		pass
	if lives == 40:
		pass
	if lives == 20:
		pass
	if lives <= 0:
		setScoreCard()
		emit_signal("gameend")
		updateGameValues()
		Global.player.kill()
		resetValues()
		print("lost by lives")

#updating game values
func updateGameValues():
	updateHighScore()
	updateTopKill()
	updateCoin()
	SaveFile.saveData()

func updateLevel():
	if update_lvl == true:
		SaveFile.gamedata.LevelsUnlocked += 1

#updating values within file 
func loadValues():
	lives  = 100
	#enemy_count = 0
	kills = 0
	update_lvl = false
	is_level_won = false
	
func loadScoreCard():
	kills_in_lvl = 0
	damage_in_lvl = 0
	score_in_lvl = 0
	froggy_coins =0
	
func resetValues():
	lives = 100
	#enemy_count = 0
	enemy_number = 10
	kills = 0
	bullet_amount = 250
	is_level_won = false

func setScoreCard():
	kills_in_lvl = kills
	damage_in_lvl = 100 - lives
	score_in_lvl = kills * highest_score/2

	#updating game data 

func updateHighScore():
	if SaveFile.gamedata.HighScore < score_in_lvl:
		SaveFile.gamedata.HighScore = score_in_lvl
	else:
		pass

func updateTopKill():
	if SaveFile.gamedata.TopKills < kills:
		SaveFile.gamedata.TopKills = kills
	else:
		pass

func updateCoin():
	SaveFile.gamedata.FroggyCoins += froggy_coins
	SaveFile.saveData()

func user_earned_rewarded():
	gamedata.FroggyCoins += 50
	SaveFile.saveData()
