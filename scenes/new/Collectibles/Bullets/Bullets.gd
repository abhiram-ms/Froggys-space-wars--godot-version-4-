extends Area2D

@export var bullet_increase: int = 50;
@export var deathparticle : PackedScene
@onready var explode_gradient = load(str("res://scenes/new/vfx/Explotion/gradients/explotion_2color.tres"))
func _ready():
	lerp(position,Global.player.global_position,0.1)

func explode():
	var _particle = deathparticle.instantiate()
	_particle.position = global_position
	_particle.rotation =global_rotation 
	_particle.gradient = explode_gradient
	_particle.emitting = true
	get_parent().add_child(_particle)

func completeExplotion():
	explode()
	queue_free()
	

func _on_BulletsArea_body_entered(body):
	if body == Global.player:
		Livescounter.bullet_amount += bullet_increase
		completeExplotion()
	else:
		completeExplotion()



func _on_BulletsArea_area_entered(area):
	if area.is_in_group("enemyBullet"):
		area.completeExplotion()
		
