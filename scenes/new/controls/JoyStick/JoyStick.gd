extends Control

var start_pos: Vector2 = Vector2.ZERO
var end_pos: Vector2 = Vector2.ZERO
var valid_pos = false

@onready var vfxText = $vfxText
@onready var specialbutton = $Control/Special

@onready var js_pos = get_node("Background").position
@onready var js_bg = get_node("Background")
@onready var js_handle = get_node("Background/Handle")

func _ready():
	Global.vfxText = vfxText
	vfxText.visible = false
	specialbutton.visible = false

signal swipe_detect(swipe_direction,strength)
signal swipe_end

func _input(event : InputEvent) -> void:
	if valid_pos:
		if event is InputEventScreenDrag:
			if start_pos == Vector2.ZERO:
				start_pos = event.position
				js_bg.position = Vector2(start_pos.x - 128, start_pos.y - 128)
			end_pos = event.position
			var direction = (end_pos - start_pos)
			if direction.length() < 120:
				js_handle.position.x = 78 + direction.length()
				js_handle.pivot_offset.x = 50 - direction.length()
			js_handle.rotation = rad_to_deg(direction.angle())
#			self.connect("swipe_detect",Global.player,"_on_JoyStick_swipe_detect")
			emit_signal("swipe_detect",direction, direction.length())


func _on_AreaClickButton_button_down():
	valid_pos = true 


func _on_AreaClickButton_button_up():
#	self.connect("swipe_end",Global.player,"_on_JoyStick_swipe_end")
	emit_signal("swipe_end")
	js_bg.position = js_pos
	start_pos = Vector2.ZERO
	end_pos = Vector2.ZERO
	valid_pos = false
	js_handle.position.x = 78
	js_handle.pivot_offset.x = 50


func _on_TouchScreenButton_pressed():
	Global.player.checkfire()

func startTimer():
	specialbutton.visible = false
	$Timer.start()


func _on_Dash_pressed():
	Global.player.weapon = Global.player.LASERBULLET
	Global.player.startTimer()


func _on_Timer_timeout():
	specialbutton.visible = true
	await get_tree().create_timer(10).timeout
	startTimer()
