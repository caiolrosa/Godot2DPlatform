extends Unlockable

class_name Door

onready var TopFrameSprite: Sprite = $CollisionArea/TopFrame
onready var KeyHoleFrameSprite: Sprite = $CollisionArea/KeyHoleFrame
onready var DoorOpenAudioPlayer: AudioStreamPlayer2D = $DoorOpenAudioPlayer

export(PackedScene) var next_level

var is_open = false
var _DOOR_TYPE_TEXTURES = {
	"top_frame_open": preload("res://Assets/Doors/platformPack_tile048.png"),
	"key_hole_frame_open": preload("res://Assets/Doors/platformPack_tile057.png"),
	UNLOCKABLE_TYPE.BLUE: {
		"top_frame": preload("res://Assets/Doors/platformPack_tile049.png"),
		"key_hole_frame": preload("res://Assets/Doors/platformPack_tile058.png")
	},
	UNLOCKABLE_TYPE.YELLOW: {
		"top_frame": preload("res://Assets/Doors/platformPack_tile050.png"),
		"key_hole_frame": preload("res://Assets/Doors/platformPack_tile059.png")
	},
	UNLOCKABLE_TYPE.GREEN: {
		"top_frame": preload("res://Assets/Doors/platformPack_tile051.png"),
		"key_hole_frame": preload("res://Assets/Doors/platformPack_tile060.png")
	},
	UNLOCKABLE_TYPE.RED: {
		"top_frame": preload("res://Assets/Doors/platformPack_tile052.png"),
		"key_hole_frame": preload("res://Assets/Doors/platformPack_tile061.png")
	}
}

func _on_body_entered(body: PhysicsBody2D):
	if not is_open and body is Player:
		pass

func _ready():
	assert(next_level != null)
	TopFrameSprite.texture = _DOOR_TYPE_TEXTURES[type]["top_frame"]
	KeyHoleFrameSprite.texture = _DOOR_TYPE_TEXTURES[type]["key_hole_frame"]
	EventBroker.connect(EventBroker.KEY_COLLECTED_EVENT, self, "_on_open")

func _on_open(key_type):
	if key_type != type:
		return
	
	is_open = true
	TopFrameSprite.texture = _DOOR_TYPE_TEXTURES["top_frame_open"]
	KeyHoleFrameSprite.texture = _DOOR_TYPE_TEXTURES["key_hole_frame_open"]
	DoorOpenAudioPlayer.play()
