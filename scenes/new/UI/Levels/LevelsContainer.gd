extends ScrollContainer

var swype = false
var swypePoint = null
var swypeDX = 0

func inputEvent(ev):
	if ev is InputEventMouseButton and ev.pressed:
		swype = true
		swypePoint = ev.position.x
		swypeDX = 0

	elif ev is InputEventMouseButton and !ev.pressed:
		swype = false

		var tween = create_tween()

		tween.tween_property(
			self,
			"scroll_horizontal",
			scroll_horizontal - 2 * swypeDX,
			0.5
		)

		swypePoint = null

	elif swype and ev is InputEventMouseMotion:
		scroll_horizontal -= ev.position.x - swypePoint

		swypeDX = ev.position.x - swypePoint
