extends Node

var _state = {}

func _ready():
	_state = _init_state()

func _init_state() -> Dictionary:
	return {
		EntityTypes.PLAYER: {
			"health_points": 100,
			"diamonds": 0
		}
	}

func dispatch(action: Dictionary):
	EventBroker.dispatch(EventBroker.STORE_DISPATCH_EVENT, [_state, action])

func reset_state():
	_state = _init_state()

func get_state(entity: int = -1):
	if entity == -1:
		return _state
	return _state[entity]