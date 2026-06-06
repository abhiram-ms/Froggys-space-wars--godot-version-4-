extends Control

@onready var shaderTimer = $ShaderTimer

@onready var vignette = $Vignette
@onready var mirage = $Mirage
@onready var greyScale = $GreyScale
@onready var pixel = $Pixel
#onready var negative = $Negative
@onready var contrast = $Contrast
@onready var sepia = $Sepia
#onready var normalise = $Normalise
#onready var bcs = $Bcs
@onready var wave = $wave

@onready var shaders = [vignette,mirage,greyScale,pixel,sepia,]

var is_running = false

func _ready():
	Global.shaders = self
	is_running = false
	disableVisibility()

func activateShader():
	disableVisibility()
	var random = randi() % (shaders.size())
	print("this is the random shader" + str(random))
	shaders[random].visible = true
	print(shaders[random])
	shaderTimer.start()
	
func _on_ShaderTimer_timeout():
	disableVisibility()

func disableVisibility():
	vignette.visible = false
	mirage.visible = false
	greyScale.visible = false
	pixel.visible = false
	contrast.visible =false
	sepia.visible =false
	wave.visible = false

#func activateWave():
#	wave.visible = true
