extends CharacterBody2D
class_name Player

var frog2_tex = preload("res://Assets/Character/Froggy3.png")
 
@export var speed: int = 0
@export var Totallife: int = 100
@export var index: int = 1

var Extravelocity = Vector2.ZERO
var direction = Vector2.ZERO
var thrust = 1
var fire_angle = 0
var is_flipped = false

@onready var gunpos = $Top/Gun/Node2D/gunpos
@onready var weaponpos = $Top/Gun/Node2D/weapon
@onready var laserpos = $Top/Gun/Node2D/laserpos
@onready var animation = $AnimationPlayer
@onready var gun = $Top/Gun
@onready var timer = $Timer
#onready var top = $Top

enum{
	DASH,
	NORMAL,
}
var state = NORMAL

enum{
	BULLET,
	LASERBULLET,
	LASER,
}
var weapon = BULLET

var laser_casting = false
#signal life_exhausted

func _ready():
	Global.player = self
	Livescounter.lives = Totallife
#	makeTexture()
	animation.play("thrust")

func makeTexture():
	if SaveFile.gamedata.SpaceShipCurrent == 2:
		$Top.texture = frog2_tex

func _process(delta):
#	$Sprite.position = self.position
	if Input.is_action_pressed("ui_accept"):
		checkfire()
	if Input.is_action_just_pressed("ui_down"):
		#takeScreenshot()
		state = DASH
	if Input.is_action_just_pressed("ui_up"):
		weapon = LASER
	set_velocity(direction*speed + Extravelocity)
	move_and_slide()
	Extravelocity = lerp(Extravelocity,Vector2.ZERO,0.1)

func takeDamage(amount):
#	showLabel("-1")
	animation.play("takeDamage")
	Livescounter.lives -= amount


func showLabel(labelText:String):
	var label = Global.LabelShow.instantiate()
	label.position = self.global_position
	label.text = labelText
	get_parent().add_child(label)

func checkfire():
	if Livescounter.bullet_amount <= 0:
		pass
	else:
		fire()

func startTimer():
	timer.start()

func fire():
	match weapon:
		BULLET:
			FireBullet()
			gunKickBack()
		LASERBULLET:
			FireLaserBullet()
			gunKickBack()
		LASER:
			fireLaser()
			
func FireBullet():
	Livescounter.bullet_amount = Livescounter.bullet_amount-1
	var bullet1_instance = Global.bullet.instance()
	Global.camera.shake(20)
	animation.play("gunFire")
	get_parent().add_child(bullet1_instance)
	bullet1_instance.rotation_degrees = fire_angle
	bullet1_instance.direction = weaponpos.global_position - gunpos.global_position
	bullet1_instance.position = gunpos.global_position

func FireLaserBullet():
	Livescounter.bullet_amount = Livescounter.bullet_amount-1
	var bullet1_instance = Global.bulletLaser.instance()
	Global.camera.shake(20)
	animation.play("gunFire")
	get_parent().add_child(bullet1_instance)
	bullet1_instance.rotation_degrees = fire_angle
	bullet1_instance.direction = weaponpos.global_position - gunpos.global_position
	bullet1_instance.position = gunpos.global_position

func fireLaser():
	if laser_casting == false:
		laser_casting = true
		var laser_instance = Global.laser.instance()
		laser_instance.global_position = laserpos.global_position
		add_child(laser_instance)
		await get_tree().create_timer(10).timeout
		weapon = BULLET
		laser_casting = false
		remove_child(laser_instance)

func gunKickBack():
	var dir = Vector2(1, 0).rotated(self.global_rotation)
	var kick = 250
	var kickdirection = kick * (dir*-1)
	Extravelocity = Extravelocity + kickdirection

func _on_GetHit_body_entered(body):
	if body.is_in_group("enemyBullet"):
		pass

func _on_JoyStick_swipe_detect(swipe_direction, strength):
	direction = swipe_direction.normalized()
	var direction_angle = rad_to_deg(swipe_direction.angle())
	setAngle(direction_angle)
	match state:
		NORMAL:
			speed = 200
			if strength > speed:
				if strength>400:
					speed = 400
				else:
					speed = strength
		DASH:
			speed = 500
			await get_tree().create_timer(0.5).timeout
			state = NORMAL

func _on_JoyStick_swipe_end():
	direction = Vector2.ZERO

func setAngle(direction_angle):
	gun.rotation_degrees = 0
	self.rotation_degrees = direction_angle
	fire_angle = self.rotation_degrees


func _on_enemy_attract_body_entered(body):
	if body.is_in_group("enemy"):
		body.Attack_timer.start()
		body.can_move = false

func _on_enemy_attract_body_exited(body):
	if body.is_in_group("enemy"):
		body.Attack_timer.stop()
		body.can_move = true
		body.state = body.SURROUND
		
func kill():
	animation.stop()

func takeScreenshot():
	var image = get_viewport().get_texture().get_data()
	image.flip_y()
	image.save_png("res://images/screenshot2.png")

func _exit_tree():
	Global.player = null


func _on_Timer_timeout():
	weapon = BULLET
	
