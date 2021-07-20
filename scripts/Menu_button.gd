extends TextureButton

export (String) var label_text
onready var label = $Label

func _ready():
	label.text = label_text

func _on_button_down():
	label.margin_top = 0.5
	pass

func _on_button_up():
	label.margin_top = 0
	pass
