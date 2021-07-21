extends KinematicBody2D

onready var global = $"/root/global"
onready var open = $chest_open
onready var interaction = $Interaction

export (bool) var has_sword = false

func _ready():
	interaction.interaction_enabled = false
	add_to_group("chests")

func _on_interaction():
	var dialog
	if has_sword:
		dialog = global.Dialog.CHEST_SWORD
		has_sword = false
		get_tree().call_group("player", "give_weapon")
	else:
		dialog = global.Dialog.CHEST_EMPTY

	get_tree().call_group("hud", "show_dialog", dialog)
	open.visible = true

func enable_chest(sword: bool):
	has_sword = sword
	interaction.interaction_enabled = true
