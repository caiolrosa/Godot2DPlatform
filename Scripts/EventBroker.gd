extends Node

# warning-ignore:unused_signal
signal key_collected(key_type)
# warning-ignore:unused_signal
signal diamond_collected(diamond_type)
# warning-ignore:unused_signal
signal update_health_points(health_points)
# warning-ignore:unused_signal
signal switch_button_pressed(button_type)
# warning-ignore:unused_signal
signal finish_loading()
# warning-ignore:unused_signal
signal update_money(money)
# warning-ignore:unused_signal
signal apply_damage(target, damage)
# warning-ignore:unused_signal
signal fall_off_map(damage)
# warning-ignore:unused_signal
signal game_over()

const KEY_COLLECTED_EVENT        = "key_collected"
const DIAMOND_COLLECTED_EVENT    = "diamond_collected"
const UPDATE_HEALTH_POINTS_EVENT = "update_health_points"
const UPDATE_MONEY_EVENT         = "update_money"
const APPLY_DAMAGE               = "apply_damage"
const SWITCH_BUTTON_PRESSED      = "switch_button_pressed"
const FINISH_LOADING_EVENT       = "finish_loading"
const FALL_OFF_MAP_EVENT         = "fall_off_map"
const GAME_OVER_EVENT            = "game_over"

func dispatch(event: String, payload: Array = []):
	payload.push_front(event)
	callv("emit_signal", payload)
