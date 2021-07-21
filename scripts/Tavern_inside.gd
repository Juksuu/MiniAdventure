extends Node2D

signal tavern_exit

onready var global = get_node("/root/global");

var tavern_interaction_done = false
var quests_done = false

func _on_Exit_area_entered(area):
	emit_signal("tavern_exit")

func _on_interaction():
	var dialog = global.Dialog.TAVERN
	if tavern_interaction_done:
		dialog = global.Dialog.QUESTS_DONE if quests_done else global.Dialog.TAVERN_USED

	get_tree().call_group("hud", "show_dialog", dialog)
	tavern_interaction_done = true


func _on_all_enemies_killed():
	quests_done = true
