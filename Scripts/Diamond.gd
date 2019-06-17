extends Node2D

signal collected_diamond(diamond_type)

const GameManager = preload("GameManager.gd")
enum DIAMOND_TYPES { 
	LOW_COST = 150,
	MEDIUM_COST = 300,
	HIGH_COST = 450,
	MAX_COST = 600 
}
var _DIAMOND_TYPE_TEXTURES = {
	DIAMOND_TYPES.LOW_COST: load("res://Assets/Diamonds/platformPack_item007.png"),
	DIAMOND_TYPES.MEDIUM_COST: load("res://Assets/Diamonds/platformPack_item009.png"),
	DIAMOND_TYPES.HIGH_COST: load("res://Assets/Diamonds/platformPack_item008.png"),
	DIAMOND_TYPES.MAX_COST: load("res://Assets/Diamonds/platformPack_item010.png")
}

export(DIAMOND_TYPES) var diamond_type = DIAMOND_TYPES.LOW_COST
var diamond_sprite: Sprite

func _ready():
	diamond_sprite = Sprite.new()
	diamond_sprite.texture = _DIAMOND_TYPE_TEXTURES[diamond_type]
	self.add_child(diamond_sprite)

func _on_body_entered(body: PhysicsBody2D):
	if body.name == GameManager.PLAYER_NODE_NAME:
		$CoinPickupAudio.play()
		emit_signal("collected_diamond", diamond_type)
		self.visible = false

func _on_CoinPickupAudio_finished():
	queue_free()
