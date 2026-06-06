extends Area2D
class_name BulletScript

var direction = Vector2.RIGHT
var speed = 300
@onready var explode_gradient = load(str("res://scenes/new/vfx/Explotion/gradients/explotion_normal.tres"))
@export var deathparticle : PackedScene

func _ready():
#	print("############")
#	print(direction)
#	print(speed)
#	print(direction * speed )
#	print("############")
	pass

func _process(delta):
	#set_as_toplevel(true)
	translate(direction * speed * delta)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_body_entered(body):
	if body.is_in_group("enemy"):
		body.state = body.DEAD
		body.completeExplotion()
		completeExplotion()
	if body.is_in_group("enemyBullet"):
		Global.camera.shake(25)
		completeExplotion()

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
