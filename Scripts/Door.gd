extends Node2D

class_name Door

onready var top_frame_sprite: Sprite = $CollisionArea/TopFrame
onready var key_hole_frame_sprite: Sprite = $CollisionArea/KeyHoleFrame

export(Texture) var top_frame_texture
export(Texture) var key_hole_frame_texture
export(Texture) var top_frame_open_texture
export(Texture) var key_hole_open_texture

func _on_body_entered(body: PhysicsBody2D):
	if body is Player:
		top_frame_sprite.texture = top_frame_open_texture
		key_hole_frame_sprite.texture = key_hole_open_texture

func _ready():
	assert_textures_exist()
	top_frame_sprite.texture = top_frame_texture
	key_hole_frame_sprite.texture = key_hole_frame_texture

func assert_textures_exist():
	assert( top_frame_texture      != null and 
			key_hole_frame_texture != null and 
			top_frame_open_texture != null and
			key_hole_open_texture  != null )