extends Player

@export var is_firing: bool = false

func FireBullet():
	if is_firing  == false:
		Livescounter.bullet_amount = Livescounter.bullet_amount-1
		Global.camera.shake(20)
		animation.play("gunFire")
	
