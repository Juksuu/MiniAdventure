extends KinematicBody2D

signal crab_killed

const MAX_HP = 100
const KNOCKBACK_VELOCITY = 100
const FRICTION = 200
const SPEED = 50
const ACCELERATION = 500

onready var hurtbox_shape = $Hurtbox/CollisionShape2D
onready var player_detection = $PlayerDetection
onready var animated_sprite = $AnimatedSprite

enum State {
	IDLE,
	WANDER,
	CHASE
}

var current_state = State.IDLE
var current_hp = MAX_HP
var knockback = Vector2.ZERO
var velocity = Vector2.ZERO
var attacking = false

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	if player_detection.is_player_in_area():
		current_state = State.CHASE
	else:
		current_state = State.IDLE
		attacking = false
	
	match current_state:
		State.IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			pass
		State.WANDER:
			pass
		State.CHASE:
			var player = player_detection.player
			var direction = (player.global_position - global_position).normalized()
			velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	
	velocity = move_and_slide(velocity)
	
	if attacking:
		animated_sprite.animation = "attack"
		return
		
	if velocity != Vector2.ZERO:
		animated_sprite.animation = "move"
	else:
		animated_sprite.animation = "idle"
	


func _on_hurtbox_entered(area):
	knockback = area.knockback_vector * KNOCKBACK_VELOCITY
	current_hp -= 50
	if current_hp <= 0:
		emit_signal("crab_killed")
		queue_free()

func get_size() -> Vector2:
	return hurtbox_shape.shape.extents


func _on_hitbox_entered(area):
	attacking = true

func _on_hitbox_exited(area):
	attacking = false
