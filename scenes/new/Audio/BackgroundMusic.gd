extends AudioStreamPlayer2D


func _ready():
	pass # Replace with function body.
	
func fadeMusic():
	$".".volume_db = -5
	
#func changeMusic():
#	$".".stream = 
