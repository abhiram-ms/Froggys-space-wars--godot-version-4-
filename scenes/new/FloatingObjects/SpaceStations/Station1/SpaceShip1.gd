extends Area2D

@export var Totaldamage: int = 100
@export var damage: int = 5
@export var x: int = 500
@export var y: int = 0
@export var enemy_timer: float =1

@export var deathparticle : PackedScene

@onready var enemyTimer = $EnemyTimer
@onready var animation = $AnimationPlayer
@onready var progress = $ProgressBar

enum{
	ENEMY1,
	ENEMY2,
}
var enemy = ENEMY1
var enemyNode = Global.enemy

func _ready():
	enemyTimer.wait_time = enemy_timer
	var parent_pos = get_parent().global_position
	self.position.x = parent_pos.x + x
	self.position.y = parent_pos.y + y
	progress.max_value = Totaldamage

func takeDamage():
	Totaldamage -= damage;

func _process(delta):
	progress.value = Totaldamage
	if Totaldamage <= 0:
		completeExplotion()

func _on_EnemyTimer_timeout():
	#if Livescounter.enemy_count < Livescounter.enemy_number:
		var instance = enemyNode.instantiate()
		instance.global_position = self.global_position
		get_node("../../").add_child(instance)
		#Livescounter.enemy_count += 1
#		var instance1 = Global.SpaceShip2.instance()
#		instance1.global_position = self.global_position
#		get_parent().add_child(instance1)

func _on_SpaceShip1_area_entered(area):
	if area.is_in_group("playerBullet"):
		animation.play("TakeDamage")
		Global.camera.shake(25)
		takeDamage()

func setTimers():
	enemyTimer.wait_time = enemy_timer

func completeExplotion():
	explode()
	queue_free()
	
func explode():
	var _particle = deathparticle.instantiate()
	_particle.position = global_position
	_particle.rotation =global_rotation 
	_particle.emitting = true
	get_node("../../").add_child(_particle)


func _on_Timer_timeout():
	match enemy:
		ENEMY1:
			enemy = ENEMY2
			enemyNode = Global.enemy2
		ENEMY2:
			enemy = ENEMY1
			enemyNode = Global.enemy
