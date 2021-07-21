extends KinematicBody2D

const SPEED = 80
const ACCELERATION = 500
const FRICTION = 400
const START_HP = 100

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

onready var hud = $Control/Camera2D/Player_hud
onready var hitbox = $HitboxPivot/Hitbox
onready var timer = $Dmgtimer

var velocity = Vector2.ZERO
var isWeaponEquipped = false
var has_weapon = false
var current_health = START_HP
var can_move = true
var can_take_dmg = true
var should_take_dmg = false
var dead = false

func _ready():
	hud.init(current_health)
	hitbox.knockback_vector = Vector2.DOWN

func _input(_ev):
	if dead:
		return

	if Input.is_key_pressed(KEY_SPACE):
		if !has_weapon:
			return

		isWeaponEquipped = !isWeaponEquipped
		animationState.start("IdleWep") if isWeaponEquipped else animationState.start("Idle")

	elif Input.is_key_pressed(KEY_F) and isWeaponEquipped:
		animationState.travel("Attack")


func _physics_process(delta):
	if dead:
		return
		
	if can_take_dmg and should_take_dmg:
		take_dmg()
		
	if !can_move:
		return
	
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	inputVector = inputVector.normalized()

	if inputVector != Vector2.ZERO:
		hitbox.knockback_vector = inputVector
		animationState.travel("WalkWep") if isWeaponEquipped else animationState.travel("Walk")
		setAnimationDir(inputVector)
		velocity = velocity.move_toward(inputVector * SPEED, ACCELERATION * delta)
	else:
		animationState.travel("IdleWep") if isWeaponEquipped else animationState.travel("Idle")
		velocity = velocity.move_toward(inputVector, FRICTION * delta)

	move_and_slide(velocity)
	
	if dead:
		animationState.travel("Death")

func give_weapon():
	has_weapon = true
	hud.update_quests()

func set_move_status(status: bool):
	can_move = status

func setAnimationDir(dir: Vector2):
	animationTree.set("parameters/Attack/blend_position", dir)
	animationTree.set("parameters/Idle/blend_position", dir)
	animationTree.set("parameters/IdleWep/blend_position", dir)
	animationTree.set("parameters/Walk/blend_position", dir)
	animationTree.set("parameters/WalkWep/blend_position", dir)	
	
func take_dmg():
	print("take dmg")
	current_health -= 20
	hud.update_health(current_health)
	if current_health <= 0:
		die()
	can_take_dmg = false
	timer.start()
	
func die():
	dead = true
	animationState.travel("Death")

func _on_hurtbox_entered(area):
	should_take_dmg = true

func _on_hurtbox_exited(area):
	should_take_dmg = false

func _on_dmg_timer_finish():
	can_take_dmg = true
