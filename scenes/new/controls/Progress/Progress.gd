extends CanvasLayer

# Called when the node enters the scene tree for the first time.
@onready var indicator = $Indicator
@onready var lifeContainer = $ProgressBar/LifeContainer/Life
@onready var killContainer = $ProgressBar/KillContainer/kills
@onready var bulletContainer = $ProgressBar/BulletContainer/bullets


var planetPosition;
const ROTATION_SPEED = 20;

func _ready():
#	indicator.visible = true
	get_tree().paused = false
	Livescounter.connect("gameend", Callable(self, "_on_game_end"))
	$GameOver.visible = false
	$ColorRect.visible = false
	$VBoxContainer.visible = false
#	$VBoxContainer/resume.visible = false
#	$VBoxContainer/quit.visible = false
	lifeContainer.max_value = Livescounter.lives
	lifeContainer.value = Livescounter.lives
	killContainer.value = Livescounter.kills
	bulletContainer.value = Livescounter.bullet_amount
	
func _physics_process(delta):
#	setIndicator(delta)
	$Coins.text = str(Livescounter.froggy_coins)
	lifeContainer.value = Livescounter.lives
	killContainer.value = Livescounter.kills
	bulletContainer.value = Livescounter.bullet_amount

func setIndicator():
	if Global.RotatedPlanet != null:
		indicator.look_at(Global.RotatedPlanet.position)
	pass
	
func _on_game_end():
	get_tree().paused = true
	$ProgressBar.visible = false
	$GameOver.visible = true


func _on_Button_pressed():
	get_tree().paused = true
	$ColorRect.visible = true
	$VBoxContainer.visible =true
#	$VBoxContainer/resume.visible = true
#	$VBoxContainer/quit.visible = true


func _on_resume_pressed():
	get_tree().paused = false
	$ColorRect.visible = false
	$VBoxContainer.visible = false
#	$VBoxContainer/resume.visible = false
#	$VBoxContainer/quit.visible = false


func _on_quit_pressed():
	$ColorRect.visible = false
	$VBoxContainer.visible = false
#	$VBoxContainer/resume.visible = false
#	$VBoxContainer/quit.visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/new/UI/MainMenu/scene1.tscn")
	
	


func _on_Timer_timeout():
#	setIndicator()
	pass
