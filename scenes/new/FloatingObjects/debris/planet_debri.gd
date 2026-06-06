extends RigidBody2D

var direction = Vector2.ZERO
var speed = 20

@export var deathparticle: PackedScene

func _ready():
	linear_velocity = Vector2(30, 0).rotated(randf() * TAU)

func explode():
	var particle = deathparticle.instantiate()

	particle.position = global_position
	particle.rotation = global_rotation
	particle.emitting = true

	get_parent().add_child(particle)

func _on_timer_timeout():
	explode()
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("playerBullet"):
		completeExplotion()

	elif body.is_in_group("enemyBullet"):
		completeExplotion()

	elif body == Global.player:
		completeExplotion()

	elif body.is_in_group("enemy"):
		completeExplotion()

func completeExplotion():
	explode()
	queue_free()
