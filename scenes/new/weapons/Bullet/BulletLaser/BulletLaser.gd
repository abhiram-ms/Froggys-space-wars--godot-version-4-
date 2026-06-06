extends BulletScript

@onready var animation = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("fadeIN")
	



func _on_BulletLaser_body_entered(body):
	if body.is_in_group("enemy"):
		body.state = body.DEAD
		body.died.start()
	if body.is_in_group("enemyBullet"):
		Global.camera.shake(25)
