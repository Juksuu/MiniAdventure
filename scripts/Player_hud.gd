extends Control

onready var dialog_node = $Dialog
onready var hp_fill = $hp_bar/fill
onready var interact_label = $Control/Interact_label
onready var global = get_node("/root/global")

var max_health: float = 0

func init(max_hp: float):
	max_health = max_hp
	
func update_health(curr_hp):
	var decimal: float = curr_hp / max_health
	hp_fill.scale = Vector2(decimal, 1)

func show_dialog(dialog):
	dialog_node.show_dialog(dialog)
	interact_label.visible = false

func show_interact():
	interact_label.visible = true
