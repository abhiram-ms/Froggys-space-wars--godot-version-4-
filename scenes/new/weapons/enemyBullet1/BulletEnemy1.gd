extends Area2D

var direction = Vector2.RIGHT
var speed = 150


@export var deathparticle : PackedScene
@onready var enemy_fire = $enemy_fire
@export var damage: int = 1

func _process(delta):
	#set_as_toplevel(true)
	translate(direction * speed * delta)
	

func _on_BulletEnemy1_body_entered(body):
	if body == Global.player:
		body.takeDamage(damage)
		Global.camera.shake(100)
		completeExplotion()


func explode():
		var _particle = deathparticle.instantiate()
		_particle.position = global_position
		_particle.rotation =global_rotation 
		_particle.emitting = true
		get_parent().add_child(_particle)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func completeExplotion():
	explode()
	queue_free()


func _on_BulletEnemy1_area_entered(area):
	if area.is_in_group("playerBullet"):
		completeExplotion()
