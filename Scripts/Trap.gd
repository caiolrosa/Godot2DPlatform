extends Node2D

class_name Trap

export(int) var damage = 10

func _ready():
	var collision_area = get_child(0)
	if not collision_area.is_connected("body_entered", self, "_on_body_entered"):
		collision_area.connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body: PhysicsBody2D):
	EventBroker.dispatch(EventBroker.APPLY_DAMAGE, [body, damage])
