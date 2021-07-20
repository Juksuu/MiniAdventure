extends Control

onready var hp_fill = $hp_bar/fill

var max_health: float = 0

func init(max_hp: float):
	max_health = max_hp
	
func update_health(curr_hp):
	var decimal: float = curr_hp / max_health
	hp_fill.scale = Vector2(decimal, 1)
