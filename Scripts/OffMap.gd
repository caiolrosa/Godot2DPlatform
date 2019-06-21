extends Trap

func _on_body_entered(body: PhysicsBody2D):
	if body is Player:
		EventBroker.dispatch(EventBroker.FALL_OFF_MAP_EVENT, [damage])