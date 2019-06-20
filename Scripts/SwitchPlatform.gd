extends Unlockable

class_name SwitchPlatform

onready var SwitchPlatformCollision: StaticBody2D = $StaticBody2D
onready var SwitchPlatformSprite: Sprite = $StaticBody2D/Sprite

var is_on = false
var _TILE_TEXTURES = {
	UNLOCKABLE_TYPE.BLUE: {
		"switch_on":  load("res://Assets/PuzzelTiles/platformPack_tile007.png"),
		"switch_off": load("res://Assets/PuzzelTiles/platformPack_tile009.png")
	},
	UNLOCKABLE_TYPE.YELLOW: {
		"switch_on":  load("res://Assets/PuzzelTiles/platformPack_tile008.png"),
		"switch_off": load("res://Assets/PuzzelTiles/platformPack_tile010.png")
	},
	UNLOCKABLE_TYPE.GREEN: {
		"switch_on":  load("res://Assets/PuzzelTiles/platformPack_tile019.png"),
		"switch_off": load("res://Assets/PuzzelTiles/platformPack_tile021.png")
	},
	UNLOCKABLE_TYPE.RED: {
		"switch_on":  load("res://Assets/PuzzelTiles/platformPack_tile020.png"),
		"switch_off": load("res://Assets/PuzzelTiles/platformPack_tile022.png")
	}
}

func _on_switch_button_pressed(button_type):
	if button_type == type && not is_on:
		SwitchPlatformSprite.texture = _TILE_TEXTURES[type]["switch_on"]
		SwitchPlatformCollision.layers = 1
		is_on = true

func _ready():
	EventBroker.connect(EventBroker.SWITCH_BUTTON_PRESSED, self, "_on_switch_button_pressed")
	SwitchPlatformSprite.texture = _TILE_TEXTURES[type]["switch_off"]
	SwitchPlatformCollision.layers = 0
