extends Node2D

signal tavern_exit

func _on_Exit_area_entered(area):
	emit_signal("tavern_exit")
