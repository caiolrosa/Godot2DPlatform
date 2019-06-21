extends Unlockable

class_name Key

onready var KeySprite: Sprite = $CollisionArea/Sprite

var _KEY_TYPE_TEXTURES = {
	UNLOCKABLE_TYPE.BLUE:   preload("res://Assets/Keys/platformPack_item013.png"),
	UNLOCKABLE_TYPE.YELLOW: preload("res://Assets/Keys/platformPack_item014.png"),
	UNLOCKABLE_TYPE.GREEN:  preload("res://Assets/Keys/platformPack_item015.png"),
	UNLOCKABLE_TYPE.RED:    preload("res://Assets/Keys/platformPack_item016.png")
}

func _on_body_entered(body: PhysicsBody2D):
	if body is Player:
		EventBroker.dispatch(EventBroker.KEY_COLLECTED_EVENT, [type])
		queue_free()

func _ready():
	KeySprite.texture = _KEY_TYPE_TEXTURES[type]
