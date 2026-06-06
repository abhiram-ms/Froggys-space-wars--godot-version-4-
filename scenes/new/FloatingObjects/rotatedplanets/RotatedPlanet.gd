extends Area2D

#var texture1 = preload("res://Assets/texture/texture1.png")
#var texture2 = preload("res://Assets/texture/texture2.png")
#var texture3 = preload("res://Assets/texture/texture3.png")
#var texture4 = preload("res://Assets/texture/texture4.png")
#var texture5 = preload("res://Assets/texture/texture5.png")
#var texture6 = preload("res://Assets/texture/texture6.png")
#var texture7 = preload("res://Assets/texture/texture7.png")
#
#var textures = [
#	texture1,
#	texture2,
#	texture3,
#	texture4,
#	texture5,
#	texture6,
#	texture7,
#]
@onready var sprite = $Sprite3
#onready var health_p = $ProgressBar

var speed = 30
var velocity = Vector2.ZERO
@export var health: int = 10
@export var deathparticle : PackedScene

func _ready():
#	print(get_parent())
#	var rand_value = textures[randi() % textures.size()]
	if get_parent().get_name() == "Main":
		$CollisionShape2D.visible = false
	else:
		self.position = get_parent().global_position
		Global.RotatedPlanet = self
#	sprite.texture = rand_value

#func _physics_process(delta):
##	move(Global.player.global_position,delta)

#
#func move(target, delta):
##	$AnimatedSprite.play("move_right")
#	var direction = (target - global_position).normalized() 
#	var desired_velocity =  direction * speed
#	var steering = (desired_velocity - velocity) * delta * 2.5
#	self.position += velocity



func _on_Area2D_area_entered(area):
	if area.is_in_group("enemyBullet"):
		area.completeExplotion()

func completeExplotion():
	explode()
	queue_free()

func explode():
		var _particle = deathparticle.instantiate()
		_particle.position = global_position
		_particle.rotation =global_rotation 
		_particle.emitting = true
		get_parent().add_child(_particle)


func _on_RotatedPlanet_body_entered(body):
	if body == Global.player:
		Livescounter.is_level_won = true
		completeExplotion()
