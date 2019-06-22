extends Control

onready var Animation: AnimationPlayer = $Animation

func _on_animation_finished(anim_name):
	if anim_name == "start":
		Animation.play("loading")
	elif anim_name == "end":
		queue_free()

func _on_finish_loading():
	Animation.play("end")

func _ready():
	Animation.play("start")
	EventBroker.connect(EventBroker.FINISH_LOADING_EVENT, self, "_on_finish_loading")
