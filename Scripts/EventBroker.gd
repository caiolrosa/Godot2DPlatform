extends Node

# warning-ignore:unused_signal
signal diamond_collected(diamond_type)
# warning-ignore:unused_signal
signal update_health_points(health_points)
# warning-ignore:unused_signal
signal update_money(money)

const DIAMOND_COLLECTED_EVENT    = "diamond_collected"
const UPDATE_HEALTH_POINTS_EVENT = "update_health_points"
const UPDATE_MONEY_EVENT         = "update_money"

func dispatch(event: String, payload: Array):
	payload.push_front(event)
	callv("emit_signal", payload)