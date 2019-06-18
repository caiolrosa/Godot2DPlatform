extends KinematicBody2D

signal update_money(money)
signal update_health_points(health_points)

const SPEED = 150
const GRAVITY = 20
const JUMP_FORCE = 400
const GROUND_NORMAL = Vector2(0, -1)

var velocity = Vector2()
var money = 0
var health_points = 100

onready var Sprite: Sprite = $Sprite
onready var JumpAudioPlayer: AudioStreamPlayer2D = $JumpAudioPlayer

func _on_collected_diamond(diamond_type):
	money += diamond_type
	emit_signal("update_money", money)

func _apply_gravity():
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, GROUND_NORMAL)
	
func _update_movement():
	velocity = move_and_slide(velocity, GROUND_NORMAL)

func _move_left():
	velocity.x = -SPEED
	Sprite.flip_h = true
	if is_on_floor():
		Sprite.play("Walk")

func _move_right():
	velocity.x = SPEED
	Sprite.flip_h = false
	if is_on_floor():
		Sprite.play("Walk")

func _jump():
	if not is_on_floor():
		return
	velocity.y = -JUMP_FORCE
	Sprite.play("JumpStart")
	JumpAudioPlayer.play()

func _idle():
	velocity.x = 0
	if is_on_floor():
		Sprite.play("Idle")
	
func _update_jump_animation():
	if not is_on_floor() && velocity.y > 0:
		Sprite.play("JumpEnd")

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
	_apply_gravity()
	_act_on_input()
	_update_jump_animation()
