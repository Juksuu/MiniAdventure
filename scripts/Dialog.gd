extends Control

signal quests_received

onready var label = $NinePatchRect/Label
onready var continue_label = $NinePatchRect/continue_label

const TAVERN_DIALOG_TEXT = [
	"Hello!\nOur village is under attack and we need someone to help us kill the monsters.",
	"That seems like the perfect job for you.\nBut first you need to find a sword to fight with.",
	"You can find an extra sword in one of the chests scattered around the village."
]

const TAVERN_USED_DIALOG = [
	"Go find that sword and kill the monsters please!"
]

var current_dialog

func _input(event):
	if Input.is_key_pressed(KEY_E) and continue_label.visible:
		get_tree().call_group("player", "set_move_status", true)
		continue_label.visible = false
		visible = false
		if current_dialog == global.Dialog.TAVERN:
			emit_signal("quests_received")

func show_dialog(dialog):
	get_tree().call_group("player", "set_move_status", false)
	visible = true
	current_dialog = dialog
	match dialog:
		global.Dialog.TAVERN:
			print("TAVERN DIALOG")
			for text in TAVERN_DIALOG_TEXT:
				label.text = text
				yield(get_tree().create_timer(4), "timeout")
			continue_label.visible = true
		global.Dialog.TAVERN_USED:
			print("TAVERN_USED DIALOG")
			for text in TAVERN_USED_DIALOG:
				label.text = text
				yield(get_tree().create_timer(2), "timeout")
			continue_label.visible = true
		_:
			print(dialog, " Dialog not implemented")
