extends KinematicBody2D

const SPEED = 80
const ACCELERATION = 500
const FRICTION = 400
const START_HP = 100

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

onready var hud = $Control/Camera2D/Player_hud

var velocity = Vector2.ZERO
var isWeaponEquipped = false
var hasWeapon = true
var current_health = START_HP
var can_move = true

func _ready():
	hud.init(current_health)

func _input(_ev):
	if Input.is_key_pressed(KEY_SPACE):
		if !hasWeapon:
			return

		isWeaponEquipped = !isWeaponEquipped
		animationState.start("IdleWep") if isWeaponEquipped else animationState.start("Idle")

	elif Input.is_key_pressed(KEY_F) and isWeaponEquipped:
		animationState.travel("Attack")


func _physics_process(delta):
	if !can_move:
		return
	
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	inputVector = inputVector.normalized()

	if inputVector != Vector2.ZERO:
		animationState.travel("WalkWep") if isWeaponEquipped else animationState.travel("Walk")
		setAnimationDir(inputVector)
		velocity = velocity.move_toward(inputVector * SPEED, ACCELERATION * delta)
	else:
		animationState.travel("IdleWep") if isWeaponEquipped else animationState.travel("Idle")
		velocity = velocity.move_toward(inputVector, FRICTION * delta)

	move_and_slide(velocity)

func set_move_status(status: bool):
	can_move = status

func setAnimationDir(dir: Vector2):
	animationTree.set("parameters/Attack/blend_position", dir)
	animationTree.set("parameters/Idle/blend_position", dir)
	animationTree.set("parameters/IdleWep/blend_position", dir)
	animationTree.set("parameters/Walk/blend_position", dir)
	animationTree.set("parameters/WalkWep/blend_position", dir)
