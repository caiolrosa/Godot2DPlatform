extends Node

var timer = Timer.new()
var loading_screen = preload("res://Scenes/LoadingScreenUI.tscn").instance()
var current_level: Node
var loader: ResourceInteractiveLoader
var root: Node

func _ready():
	timer.one_shot = true
	root = get_tree().get_root()
	current_level = root.get_child(root.get_child_count() - 1)
	set_process(false)

func next_level(scene_path: String, min_wait_sec: int = 0):
	root.add_child(timer)
	timer.start(min_wait_sec)
	call_deferred("_deferred_next_level", scene_path)

func _deferred_next_level(scene_path: String):
	loader = ResourceLoader.load_interactive(scene_path)
	current_level.queue_free()
	root.add_child(loading_screen)
	set_process(true)

func _set_new_level(new_level: Resource):
	EventBroker.dispatch(EventBroker.FINISH_LOADING_EVENT)
	current_level = new_level.instance()
	root.add_child(current_level)
	get_tree().current_scene = current_level

func _process(delta):
	if loader.poll() == ERR_FILE_EOF and timer.is_stopped():
		root.remove_child(timer)
		var new_level = loader.get_resource()
		_set_new_level(new_level)
		set_process(false)
		loader = null
