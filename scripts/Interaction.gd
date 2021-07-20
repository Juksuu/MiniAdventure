extends Area2D

signal interaction

var _can_interact = false

func _input(event):
	if Input.is_key_pressed(KEY_E) and _can_interact:
		_can_interact = false
		emit_signal("interaction")

func _on_area_entered(area):
	get_tree().call_group("hud", "show_interact")
	_can_interact = true
