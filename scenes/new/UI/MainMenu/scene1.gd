extends Node2D

signal game_started

@export var speed: int = 100
@export var rotaion_speed: float = 0.3

var direction = Vector2(0,1)
@onready var parallax = $ParallaxBackground
@onready var animation = $Animation

func _ready():
	animation.play("intro")

func _physics_process(delta):
	parallax.scroll_offset += direction*speed*delta
	direction = direction.rotated(rotaion_speed*delta)
	

func _on_Play_pressed():
	Global.currentLevel = 0
	get_tree().change_scene_to_file("res://scenes/new/UI/LoadLevelScreen/LoadLevelScreen.tscn")
	emit_signal("game_started")


func _on_Settings_pressed():
	get_tree().change_scene_to_file("res://scenes/new/UI/Settings/Settings.tscn")


func _on_Inventory_pressed():
	get_tree().change_scene_to_file("res://scenes/new/UI/Inventory/Inventory.tscn")


func _on_Exit_pressed():
	get_tree().quit() 
	
func _on_Levels_pressed():
	get_tree().change_scene_to_file("res://scenes/new/UI/Levels/Levels.tscn")

func _on_Story_pressed():
	get_tree().change_scene_to_file("res://scenes/new/UI/Story/Story.tscn")
