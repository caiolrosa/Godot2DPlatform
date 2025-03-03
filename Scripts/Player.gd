extends KinematicBody2D

class_name Player

onready var PlayerSprite: AnimatedSprite = $Sprite
onready var JumpAudioPlayer: AudioStreamPlayer2D = $JumpAudioPlayer
onready var Navigation: Navigation2D = $Navigation
onready var VFXPlayer: AnimationPlayer = $VFXAnimationPlayer
onready var start_position: Vector2 = get_position()

const SPEED = 150
const GRAVITY = 20
const JUMP_FORCE = 400
const GROUND_NORMAL = Vector2(0, -1)

var velocity = Vector2()
var path_to_spawn: PoolVector2Array

func _ready():
	EventBroker.connect(EventBroker.DIAMOND_COLLECTED_EVENT, self, "_on_collected_diamond")
	EventBroker.connect(EventBroker.APPLY_DAMAGE, self, "_on_apply_damage")
	EventBroker.connect(EventBroker.FALL_OFF_MAP_EVENT, self, "_on_fall_off_map")

func _on_collected_diamond(diamond_type: int):
	Store.dispatch(Actions.set_player_diamonds(diamond_type))

func _on_apply_damage(target: Node, damage: int):
	if target == self:
		_take_damage(damage)

func _on_fall_off_map(damage: int):
	_take_damage(damage)
	if Navigation == null:
		return
	path_to_spawn = Navigation.get_simple_path(get_position(), start_position)
	_start_ghost_mode()

func _start_ghost_mode():
	if path_to_spawn.size() > 0:
		VFXPlayer.play("GhostMode")

func _stop_ghost_mode():
	if path_to_spawn.size() == 0:
		VFXPlayer.play("NormalMode")

func _follow_spawn_path(delta):
	var next_position = path_to_spawn[0]
	if next_position.x < position.x:
		PlayerSprite.flip_h = true
	else:
		PlayerSprite.flip_h = false
	var next_distance = position.distance_to(next_position)
	var move_amount = JUMP_FORCE * delta
	if next_distance <= 0 or next_distance - move_amount < 0:
		position = next_position
		path_to_spawn.remove(0)
		_stop_ghost_mode()
		return
	position = position.linear_interpolate(next_position, move_amount / next_distance)

func _take_damage(damage):
	VFXPlayer.play("TakeDamage")
	var current_health_points = Store.get_state(EntityTypes.PLAYER).health_points
	var new_health_points = max(current_health_points - damage, 0)
	Store.dispatch(Actions.set_player_health_points(new_health_points))
	if new_health_points == 0:
		EventBroker.dispatch(EventBroker.GAME_OVER_EVENT)

func _apply_gravity():
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, GROUND_NORMAL)
	
func _update_movement():
	velocity = move_and_slide(velocity, GROUND_NORMAL)

func _move_left():
	velocity.x = -SPEED
	PlayerSprite.flip_h = true
	if is_on_floor():
		PlayerSprite.play("Walk")

func _move_right():
	velocity.x = SPEED
	PlayerSprite.flip_h = false
	if is_on_floor():
		PlayerSprite.play("Walk")

func _jump():
	if not is_on_floor():
		return
	velocity.y = -JUMP_FORCE
	PlayerSprite.play("JumpStart")
	JumpAudioPlayer.play()

func _idle():
	velocity.x = 0
	if is_on_floor():
		PlayerSprite.play("Idle")
	
func _update_jump_animation():
	if not is_on_floor() && velocity.y > 0:
		PlayerSprite.play("JumpEnd")

func _act_on_input():
	if Input.is_action_pressed("ui_left"):
		_move_left()
	elif Input.is_action_pressed("ui_right"):
		_move_right()
	else:
		_idle()
		
	if Input.is_action_just_pressed("ui_up"):
		_jump()
		
	_update_movement()

func _physics_process(delta):
	if path_to_spawn.size() == 0:
		_apply_gravity()
		_act_on_input()
		_update_jump_animation()
	else:
		_follow_spawn_path(delta)