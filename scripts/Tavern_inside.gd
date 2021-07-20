extends Node2D

signal tavern_exit

onready var global = get_node("/root/global");

var tavern_interaction_done = false

func _on_Exit_area_entered(area):
	emit_signal("tavern_exit")

func _on_interaction():
	var dialog = global.Dialog.TAVERN_USED if tavern_interaction_done else global.Dialog.TAVERN
	get_tree().call_group("hud", "show_dialog", dialog)
	tavern_interaction_done = true
