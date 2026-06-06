extends TextureRect

const SPACESHIP = "SpaceShipUnlocked"
const BULLETS = "BulletsUnlocked"

@export var amount: int = 0
@export var index: int = 0

@export_enum("SpaceShipUnlocked", "BulletsUnlocked")
var category: String = "SpaceShipUnlocked"

@export var available: bool = false

@onready var amount_text = $amount

func _ready():
	amount_text.text = str(amount)

func buyItemSpaceShip():
	if index in SaveFile.gamedata.SpaceShipUnlocked:
		OS.alert("Already purchased")
	else:
		if SaveFile.gamedata.FroggyCoins >= amount:
			SaveFile.gamedata.SpaceShipUnlocked.append(index)
			available = true
			SaveFile.gamedata.FroggyCoins -= amount
			SaveFile.saveData()
			OS.alert("Successfully purchased")
		else:
			OS.alert("Not enough coins")

func buyItemBullet():
	if index in SaveFile.gamedata.BulletsUnlocked:
		OS.alert("Already purchased")
	else:
		if SaveFile.gamedata.FroggyCoins >= amount:
			SaveFile.gamedata.BulletsUnlocked.append(index)
			available = true
			SaveFile.gamedata.FroggyCoins -= amount
			SaveFile.saveData()
			OS.alert("Successfully purchased")
		else:
			OS.alert("Not enough coins")

func useItemSpaceShip():
	if index in SaveFile.gamedata.SpaceShipUnlocked:
		SaveFile.gamedata.SpaceShipCurrent = index
		SaveFile.saveData()
		OS.alert("Successfully selected")
	else:
		OS.alert("Not purchased")

func useItemBullet():
	if index in SaveFile.gamedata.BulletsUnlocked:
		SaveFile.gamedata.BulletsCurrent = index
		SaveFile.saveData()
		OS.alert("Successfully selected")
	else:
		OS.alert("Not purchased")

func useItem():
	match category:
		SPACESHIP:
			useItemSpaceShip()
		BULLETS:
			useItemBullet()

func _on_get_pressed():
	match category:
		SPACESHIP:
			buyItemSpaceShip()
		BULLETS:
			buyItemBullet()

func _on_use_pressed():
	useItem()
