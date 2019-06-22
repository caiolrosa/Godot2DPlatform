extends Control

onready var Animation: AnimationPlayer = $Animation

func _ready():
	Animation.play("start")

func _on_try_again_button_pressed():
	LevelLoader.reset_current_level(3)

func _on_main_menu_button_pressed():
	pass
