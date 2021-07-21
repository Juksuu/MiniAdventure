extends KinematicBody2D

signal crab_killed

const MAX_HP = 100

onready var hurtbox_shape = $Hurtbox/CollisionShape2D

var current_hp = MAX_HP

func _on_hurtbox_entered(area):
	current_hp -= 50
	if current_hp <= 0:
		emit_signal("crab_killed")
		queue_free()

func get_size() -> Vector2:
	return hurtbox_shape.shape.extents
