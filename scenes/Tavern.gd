extends KinematicBody2D

signal tavern_entered

func _on_Area2D_area_entered(area):
	emit_signal("tavern_entered")
