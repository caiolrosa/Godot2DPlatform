extends HBoxContainer

export(int)     var max_hearts = 5
export(Texture) var empty_heart_texture
export(Texture) var half_heart_texture
export(Texture) var full_heart_texture

var health_points = 100
var health_step = health_points / max_hearts
var heart_sprites: Array

func _ready():
	assert( empty_heart_texture != null and 
			half_heart_texture != null and 
			full_heart_texture != null )
	_instatiate_hearts()
	
func _instatiate_hearts():
	for i in range(max_hearts):
		var texture_rect = TextureRect.new()
		texture_rect.texture = full_heart_texture
		heart_sprites.append(texture_rect)
		self.add_child(texture_rect)

func _update_heart_sprites():
	var health_count = 0
	for i in range(heart_sprites.size()):
		if health_count == health_points or health_points <= 0:
			heart_sprites[i].texture = empty_heart_texture
			continue
			
		health_count += health_step
		if health_count <= health_points:
			heart_sprites[i].texture = full_heart_texture
		else:
			health_count -= health_step / 2
			heart_sprites[i].texture = half_heart_texture

func _on_update_health_points(health_points):
	self.health_points = health_points
	_update_heart_sprites()
