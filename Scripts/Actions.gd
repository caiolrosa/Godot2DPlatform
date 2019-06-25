extends Object

class_name Actions

static func set_player_health_points(health_points: int) -> Dictionary:
	return {
		"type": ActionTypes.SET_PLAYER_HEALTH_POINTS,
		"health_points": health_points
	}

static func set_player_diamonds(diamonds: int) -> Dictionary:
	return {
		"type": ActionTypes.SET_PLAYER_DIAMONDS,
		"diamonds": diamonds
	}