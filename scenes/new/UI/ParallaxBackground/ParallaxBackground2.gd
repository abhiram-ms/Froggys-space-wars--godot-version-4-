extends ParallaxBackground

@onready var timer = $Timer
@onready var animation = $AnimatedSprite2D

func _ready():
	pass # Replace with function body.


func _on_Timer_timeout():
	animation.play("SuperNova")
