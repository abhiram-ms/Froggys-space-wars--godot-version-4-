extends CharacterBody2D
class_name EnemyScript

@onready var explode_gradient = load("res://scenes/new/vfx/Explotion/gradients/explotion_normal.tres")

@export var deathparticle: PackedScene
@export var speed: int = 500
@export var lifetime: int = 40
@export var health: int = 1
@export var Damage: int = 1
@export var attack_timer: float = 0.5

var rng = RandomNumberGenerator.new()
var Health = 1

@onready var Attack_timer = $Attack_timer
@onready var died = $died
@onready var gunpos = $Node2D/gunpos
@onready var weaponpos = $Node2D/weaponpos
@onready var lifetimer = $LifeTime
@onready var animation = $AnimationPlayer

enum {
	SURROUND,
	ATTACK,
	DEAD
}

var state = SURROUND
var randomnum
var player
var can_move = true
var deadbody = false

func _ready():
	Attack_timer.wait_time = attack_timer
	lifetimer.wait_time = lifetime
	Health = health
	rng.randomize()
	randomnum = rng.randf()

func _physics_process(delta):
	if Global.player != null:
		look_at(Global.player.global_position)

		match state:
			SURROUND:
				if can_move:
					move(get_circle_position(randomnum), delta)

			ATTACK:
				# moveAway()
				fire()
				state = SURROUND

			DEAD:
				can_move = false
				# $AnimatedSprite.play("dead")

func moveAway():
	var x = rng.randi_range(10, 50)
	var y = rng.randi_range(5, 20)
	global_position += Vector2(x, y)

func move(target: Vector2, delta: float):
	var direction = (target - global_position).normalized()
	var desired_velocity = direction * speed
	var steering = (desired_velocity - velocity) * delta * 2.5

	velocity += steering
	move_and_slide()

func get_circle_position(random_value: float) -> Vector2:
	var kill_circle_centre = Global.player.global_position
	var radius = 50

	var angle = random_value * PI * 2.0
	var x = kill_circle_centre.x + cos(angle) * radius
	var y = kill_circle_centre.y + sin(angle) * radius

	return Vector2(x, y)

func fire():
	var bullet1_instance = Global.Enemybullet.instantiate()

	get_parent().add_child(bullet1_instance)

	bullet1_instance.damage = Damage
	bullet1_instance.rotation_degrees = rotation_degrees
	bullet1_instance.direction = weaponpos.global_position - gunpos.global_position
	bullet1_instance.position = gunpos.global_position

func _on_attack_timer_timeout():
	state = ATTACK

# Compatibility for old scene signal connection names that came from Godot 3.
func _on_Attack_timer_timeout():
	_on_attack_timer_timeout()

func addBulletCollectible():
	var bullet_instance = Global.Collectbullets.instantiate()

	get_parent().add_child(bullet_instance)
	bullet_instance.position = global_position

func showLabel(labelText: String):
	var label_instance = Global.LabelShow.instantiate()

	label_instance.position = global_position
	label_instance.label_text = labelText

	get_parent().add_child(label_instance)

func _on_died_timeout():
	# explode()
	# died.start()

	Livescounter.kills += 1
	Livescounter.froggy_coins += 1

	queue_free()

func completeExplotion():
	Health -= Damage

	if Health <= 0:
		if !deadbody:
			deadbody = true
			died.start()

func explode():
	var particle = deathparticle.instantiate()

	particle.position = global_position
	particle.rotation = global_rotation
	particle.gradient = explode_gradient
	particle.emitting = true

	get_parent().add_child(particle)

func _on_life_time_timeout():
	queue_free()

# Compatibility for old scene signal connection names that came from Godot 3.
func _on_LifeTime_timeout():
	_on_life_time_timeout()

func _on_area_2d_body_entered(body):
	if body == Global.player:
		body.takeDamage(Damage)

		if Global.camera:
			Global.camera.shake(100)

		completeExplotion()

# Compatibility for old scene signal connection names that came from Godot 3.
func _on_Area2D_body_entered(body):
	_on_area_2d_body_entered(body)
