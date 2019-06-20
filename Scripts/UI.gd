extends Control

class_name UI

onready var MoneyLabel: Label = $MoneyHBox/MoneyLabel
onready var HealthBar: HeartProgressBar = $HealthHBox

func _ready():
	EventBroker.connect(EventBroker.UPDATE_MONEY_EVENT, self, "_on_player_update_money")
	EventBroker.connect(EventBroker.UPDATE_HEALTH_POINTS_EVENT, self, "_on_player_update_health_points")
	MoneyLabel.text = "0"

func _on_player_update_money(money):
	MoneyLabel.text = money as String

func _on_player_update_health_points(health_points):
	HealthBar.update_health_points(health_points)
