extends Control

func _ready():
	$MoneyLabel.text = "0"

func _on_player_update_money(money):
	$MoneyLabel.text = money as String
