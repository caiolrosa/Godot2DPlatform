extends Control

class_name UI

onready var MoneyLabel: Label = $MoneyHBox/MoneyLabel
onready var HealthBar: HeartProgressBar = $HealthHBox

func _ready():
	EventBroker.connect(EventBroker.UPDATE_DIAMONDS_EVENT, self, "_on_player_update_diamonds")
	EventBroker.connect(EventBroker.UPDATE_HEALTH_POINTS_EVENT, self, "_on_player_update_health_points")
	MoneyLabel.text = Store.get_state(EntityTypes.PLAYER).diamonds as String
	HealthBar.update_health_points(Store.get_state(EntityTypes.PLAYER).health_points)

func _on_player_update_diamonds(dimonds: int):
	MoneyLabel.text = dimonds as String

func _on_player_update_health_points(health_points: int):
	HealthBar.update_health_points(health_points)
