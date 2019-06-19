extends Control

onready var MoneyLabel: Label = $MoneyHBox/MoneyLabel

func _ready():
	EventBroker.connect(EventBroker.UPDATE_MONEY_EVENT, self, "_on_player_update_money")
	MoneyLabel.text = "0"

func _on_player_update_money(money):
	MoneyLabel.text = money as String
