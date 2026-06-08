extends Camera2D

@onready var timer = $Timer
@onready var animator = $animator
@onready var object_path = $PathObjects/ObjectFollow
@onready var object_position = $PathObjects/ObjectFollow/Position

var shake_amount = 0.0
var default_offset = offset

func _ready():
	Global.camera = self
	print("camera is ready")
	Global.cameraObjectPath = object_path
	Global.cameraObjectPosition = object_position
	set_process(false)

func _process(delta):
	offset = Vector2(
		randf_range(-shake_amount, shake_amount),
		randf_range(-shake_amount, shake_amount)
	) * delta + default_offset

func moveCamera(target_position, comebackPosition):
	get_tree().paused = true

	await get_tree().create_timer(1.0).timeout

	var tween = create_tween()
	tween.tween_property(
		self,
		"global_position",
		target_position,
		0.05
	)

	await tween.finished

	await get_tree().create_timer(2.0).timeout

	tween = create_tween()
	tween.tween_property(
		self,
		"global_position",
		comebackPosition,
		0.05
	)

	await tween.finished

	get_tree().paused = false

func moveBack():
	pass

func shake(new_shake, shake_time = 0.4, shake_limit = 150):
	shake_amount += new_shake

	if shake_amount > shake_limit:
		shake_amount = shake_limit

	timer.wait_time = shake_time

	set_process(true)
	timer.start()

func _on_timer_timeout():
	shake_amount = 0
	set_process(false)

	var tween = create_tween()
	tween.tween_property(
		self,
		"offset",
		default_offset,
		0.1
	)

# Compatibility for old scene signal connection names that came from Godot 3.
func _on_Timer_timeout():
	_on_timer_timeout()

func showBlood():
	animator.play("showBlood")
	await get_tree().create_timer(3.0, true).timeout
	animator.stop()
