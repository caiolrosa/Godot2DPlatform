extends Control

export(String, FILE, "*.tscn") var start_level

func _ready():
	assert(start_level != null)

func _on_start_game_pressed():
	LevelLoader.next_level(start_level, 2)
