extends KinematicBody2D

signal crab_killed

const MAX_HP = 100
const KNOCKBACK_VELOCITY = 100
const KNOCKBACK_FRICTION = 200

onready var hurtbox_shape = $Hurtbox/CollisionShape2D

var current_hp = MAX_HP
var knockback = Vector2.ZERO

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, KNOCKBACK_FRICTION * delta)
	knockback = move_and_slide(knockback)

func _on_hurtbox_entered(area):
	knockback = area.knockback_vector * KNOCKBACK_VELOCITY
	current_hp -= 50
	if current_hp <= 0:
		emit_signal("crab_killed")
		queue_free()

func get_size() -> Vector2:
	return hurtbox_shape.shape.extents
