extends Node

var node_creation_parent = null

var shaders = null
var camera = null
var player = null

var cameraObjectPosition;
var cameraObjectPath;
var vfxText;
var gamedata;
var RotatedPlanet;

var currentLevel = 0;

var SpaceShips = [
	preload("res://scenes/new/character/Frog1/Frog1.tscn"),
	preload("res://scenes/new/character/Frog2/Frog2.tscn")
]

#enemy in level
var enemy = preload("res://scenes/new/enemy/Enemy1/Enemy1.tscn")
var enemy2 = preload("res://scenes/new/enemy/Enemy2/Enemy2.tscn")
var SpaceShip2 = preload("res://scenes/new/FloatingObjects/SpaceStations/Station2/SpaceShip2.tscn")

#weapons in character
var bullet = preload("res://scenes/new/weapons/Bullet/Bullet.tscn")
var bulletLaser = preload("res://scenes/new/weapons/Bullet/BulletLaser/BulletLaser.tscn")
var laser = preload("res://scenes/new/weapons/Laser/Laser.tscn")

#floating objects and collectibles
var floatingObjects = preload("res://scenes/new/FloatingObjects/planets/planet.tscn")
var blackhole = preload("res://scenes/new/FloatingObjects/BlackHole/BlackHole.tscn")
var health = preload("res://scenes/new/Collectibles/Coins/Health.tscn")
var Collectbullets = preload("res://scenes/new/Collectibles/Bullets/Bullets.tscn")
var rotated_planet = preload("res://scenes/new/FloatingObjects/rotatedplanets/RotatedPlanet.tscn")
var LabelShow = preload("res://scenes/new/vfx/Labels/Labels.tscn")

#enemy weapons
var Enemybullet = preload("res://scenes/new/weapons/enemyBullet1/BulletEnemy1.tscn")

var Playerbullets = []

func _ready():
	gamedata = SaveFile.gamedata
#	Playerbullets = gamedata.BulletsUnlocked
	print(gamedata)
	print("player bullets" + str(Playerbullets))


func instance_node(node,location,parent):
	var node_instance = node.instantiate()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance