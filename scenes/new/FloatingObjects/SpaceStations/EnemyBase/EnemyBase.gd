extends Node2D

@export var xpos: int = 500
@export var ypos: int = 0

func _ready():
	self.position.x = xpos
	self.position.y = ypos

