extends Area2D


func _ready():
	pass # Replace with function body.


func _on_BlackHole_body_entered(body):
	if body == Global.player:
		body.state = body.DASH
		Global.shaders.activateShader()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
