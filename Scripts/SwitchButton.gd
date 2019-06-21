extends Unlockable

class_name SwitchButton

onready var SwitchButtonSprite: Sprite = $CollisionArea/Sprite

var _BUTTON_TEXTURES = {
	UNLOCKABLE_TYPE.BLUE: {
		"switch_on":  load("res://Assets/PuzzleTiles/platformPack_tile054.png"),
		"switch_off": load("res://Assets/PuzzleTiles/platformPack_tile053.png")
	},
	UNLOCKABLE_TYPE.YELLOW: {
		"switch_on":  load("res://Assets/PuzzleTiles/platformPack_tile056.png"),
		"switch_off": load("res://Assets/PuzzleTiles/platformPack_tile055.png")
	},
	UNLOCKABLE_TYPE.GREEN: {
		"switch_on":  load("res://Assets/PuzzleTiles/platformPack_tile063.png"),
		"switch_off": load("res://Assets/PuzzleTiles/platformPack_tile062.png")
	},
	UNLOCKABLE_TYPE.RED: {
		"switch_on":  load("res://Assets/PuzzleTiles/platformPack_tile065.png"),
		"switch_off": load("res://Assets/PuzzleTiles/platformPack_tile064.png")
	}
}

func _on_body_entered(body):
	if body is Player:
		EventBroker.dispatch(EventBroker.SWITCH_BUTTON_PRESSED, [type])
		SwitchButtonSprite.texture = _BUTTON_TEXTURES[type]["switch_on"]

func _ready():
	SwitchButtonSprite.texture = _BUTTON_TEXTURES[type]["switch_off"]

