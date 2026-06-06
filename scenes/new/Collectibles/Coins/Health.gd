extends Area2D

@export var bullet_increase: int = 50;
@export var deathparticle : PackedScene

func _ready():
	pass

func explode():
	var _particle = deathparticle.instantiate()
	_particle.position = global_position
	_particle.rotation =global_rotation 
	_particle.emitting = true
	get_parent().add_child(_particle)

func completeExplotion():
	queue_free()



func _on_Health_body_entered(body):
	if body == Global.player:
		if Livescounter.lives < 100:
			Livescounter.lives += 10
			completeExplotion()


func _on_Health_area_entered(area):
	if area.is_in_group("enemyBullet"):
		area.completeExplotion()
		
