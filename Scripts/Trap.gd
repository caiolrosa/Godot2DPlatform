extends Node2D

class_name Trap

onready var TrapSprite: Sprite = $CollisionArea/Sprite

enum TRAP_TYPE { SPIKE, SAW }
var _TRAP_TYPES_TEXTURES = {
	TRAP_TYPE.SPIKE: load("res://Assets/Traps/platformPack_tile043.png"),
	TRAP_TYPE.SAW: load("res://Assets/Traps/platformPack_tile044.png")
}

export(int) var damage = 10
export(TRAP_TYPE) var type = TRAP_TYPE.SPIKE

func _on_body_entered(body):
	EventBroker.dispatch(EventBroker.APPLY_DAMAGE, [body, damage])

func _ready():
	TrapSprite.texture = _TRAP_TYPES_TEXTURES[type]
