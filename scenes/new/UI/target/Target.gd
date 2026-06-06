extends Control


@onready var target_cord = $target_cord
@onready var your_cord = $your_cord
@onready var animation = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("intro")
#	target_cord.text = str(Global.RotatedPlanet.global_position)
#	your_cord.text = str(Global.player.global_position)


func _physics_process(delta):
	target_cord.text = str(Global.RotatedPlanet.global_position)
	your_cord.text = str(Global.player.global_position)
