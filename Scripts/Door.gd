extends Node2D

class_name Door

onready var TopFrameSprite: Sprite = $CollisionArea/TopFrame
onready var KeyHoleFrameSprite: Sprite = $CollisionArea/KeyHoleFrame
onready var DoorOpenAudioPlayer: AudioStreamPlayer2D = $DoorOpenAudioPlayer

export(Texture) var top_frame_texture
export(Texture) var key_hole_frame_texture
export(Texture) var top_frame_open_texture
export(Texture) var key_hole_open_texture

var is_open = false

func _on_body_entered(body: PhysicsBody2D):
	if not is_open and body is Player:
		_open()

func _ready():
	_assert_textures_exist()
	TopFrameSprite.texture = top_frame_texture
	KeyHoleFrameSprite.texture = key_hole_frame_texture

func _open():
	is_open = true
	TopFrameSprite.texture = top_frame_open_texture
	KeyHoleFrameSprite.texture = key_hole_open_texture
	DoorOpenAudioPlayer.play()

func _assert_textures_exist():
	assert( top_frame_texture      != null and 
			key_hole_frame_texture != null and 
			top_frame_open_texture != null and
			key_hole_open_texture  != null )