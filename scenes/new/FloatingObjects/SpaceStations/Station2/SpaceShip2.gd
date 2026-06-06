extends Area2D

@export var Health: int = 100
@export var damage: int = 5
@export var responseTime: int = 1
@export var x: int = 500
@export var y: int = 0

@onready var gunpos =$Node2D/Gunpos
@onready var weaponpos =$Node2D/WeaponPos
@onready var animation = $AnimationPlayer
@onready var timer =$Timer
@onready var progress = $ProgressBar
@export var deathparticle : PackedScene

enum{
	PATROL,
	SHOOT,
}

var state = PATROL

func _ready():
	var parent_pos = get_parent().global_position
	self.position.x = parent_pos.x + x
	self.position.y = parent_pos.y + y
	progress.max_value = Health
	progress.value = Health
	timer.wait_time = responseTime

func _physics_process(delta):
	progress.value = Health
	if Health <= 0:
		completeExplotion()

func fire():
	var bullet1_instance = Global.Enemybullet.instance()
	get_node("../../").call_deferred("add_child",bullet1_instance)
	bullet1_instance.damage = 10
	bullet1_instance.rotation_degrees = self.rotation_degrees
	bullet1_instance.direction = weaponpos.global_position - gunpos.global_position
	bullet1_instance.position = gunpos.global_position

func takeDamage():
	animation.play("TakeDamage")
	Health -= 5

func _on_detectPlayer_body_entered(body):
	if body == Global.player:
		look_at(body.global_position)
		fire()


func _on_Timer_timeout():
	animation.play("patrol")

func completeExplotion():
	explode()
	queue_free()
	
func explode():
	var _particle = deathparticle.instantiate()
	_particle.position = global_position
	_particle.rotation =global_rotation 
	_particle.emitting = true
	get_parent().add_child(_particle)


func _on_SpaceShip2_area_entered(area):
	if area.is_in_group("playerBullet"):
		animation.play("TakeDamage")
		Global.camera.shake(25)
		takeDamage()
