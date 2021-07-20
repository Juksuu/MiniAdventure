extends Control

onready var label = $item_desc

func set_text(text):
	label.text = text
	
func get_line_count() -> int:
	return label.get_line_count()
