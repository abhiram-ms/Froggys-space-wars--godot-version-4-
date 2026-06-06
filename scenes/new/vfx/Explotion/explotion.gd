extends CPUParticles2D

@export var gradient: Gradient;

func _ready():
	self.color_ramp = gradient

