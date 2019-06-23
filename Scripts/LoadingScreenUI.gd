extends Control

onready var Animation: AnimationPlayer = $Animation

func _on_animation_finished(anim_name):
	if anim_name == "start":
		Animation.play("loading")
	elif anim_name == "end":
		get_tree().get_root().remove_child(self)

func _on_finish_loading():
	Animation.play("end")

func _enter_tree():
	if (Animation != null):
		Animation.play("start")

func _ready():
	Animation.play("start")
	EventBroker.connect(EventBroker.FINISH_LOADING_EVENT, self, "_on_finish_loading")
