extends Area2D

signal interaction

var _can_interact = false
var interaction_enabled = true

func _input(event):
	if Input.is_key_pressed(KEY_E) and _can_interact:
		_can_interact = false
		emit_signal("interaction")

func _on_area_entered(area):
	if !interaction_enabled:
		return

	get_tree().call_group("hud", "show_interact")
	_can_interact = true


func _on_Interaction_area_exited(area):
	if !interaction_enabled:
		return

	get_tree().call_group("hud", "hide_interact")
	_can_interact = false
