extends Node

func _ready():
	EventBroker.connect(EventBroker.STORE_DISPATCH_EVENT, self, "_player")

func _player(state: Dictionary, action: Dictionary):
	if action["type"] == ActionTypes.SET_PLAYER_HEALTH_POINTS:
		var health_points = action["health_points"]
		state[EntityTypes.PLAYER]["health_points"] = health_points
		EventBroker.dispatch(EventBroker.UPDATE_HEALTH_POINTS_EVENT, [health_points])
	elif action["type"] == ActionTypes.SET_PLAYER_DIAMONDS:
		var diamonds = action["diamonds"]
		state[EntityTypes.PLAYER]["diamonds"] += diamonds
		EventBroker.dispatch(EventBroker.UPDATE_DIAMONDS_EVENT, [state[EntityTypes.PLAYER]["diamonds"]])