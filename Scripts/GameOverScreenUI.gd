extends Control

onready var Animation: AnimationPlayer = $Animation

func _ready():
	Animation.play("start")

func _on_try_again_button_pressed():
	EventBroker.dispatch(EventBroker.RESET_CURRENT_LEVEL_EVENT)

func _on_main_menu_button_pressed():
	pass
