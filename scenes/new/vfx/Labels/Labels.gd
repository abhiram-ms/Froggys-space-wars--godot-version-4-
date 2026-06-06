extends Label

@onready var animation = $AnimationPlayer
@onready var timer = $Timer
@export var waiting_time: int = 10
@export var label_text: String = "1"

# Called when the node enters the scene tree for the first time.
func _ready():
	text = label_text
	timer.wait_time = waiting_time
#	animation.play("showLabel")




func _on_Timer_timeout():
	queue_free()
