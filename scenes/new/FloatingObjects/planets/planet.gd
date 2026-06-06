extends RigidBody2D

@export var speed: int
@export var deathparticle: PackedScene
@export var debris: PackedScene
@export var amount: int
@export var p_torque: int = 500

@onready var timer = $Timer
@onready var visibility = $Visibility

var increasing_position = Vector2.ZERO
var direction = Vector2.ZERO
var thrust = Vector2(0, -250)
var previous_torque = 0

var my_position = Vector2(-100, -100)
var previous_position = Vector2.ZERO

func _ready():
	if Global.player:
		look_at(Global.player.global_position)

	linear_velocity = Vector2(150, 150)

func _integrate_forces(state):
	apply_force(increasing_position - previous_position, my_position)

	previous_position = increasing_position

	apply_torque(p_torque - previous_torque)

	previous_torque = p_torque

func _on_area_body_entered(body):
	completeExplotion()

func explode():
	var particle = deathparticle.instantiate()

	particle.position = global_position
	particle.rotation = global_rotation
	particle.emitting = true

	get_parent().add_child(particle)

func explodeParts():
	for i in range(amount):
		var debris_instance = debris.instantiate()

		debris_instance.position = global_position

		get_parent().add_child(debris_instance)

func _on_timer_timeout():
	completeExplotion()

func completeExplotion():
	explodeParts()
	explode()
	queue_free()
