extends Control

var game_scene = preload("res://scenes/World.tscn")

func _ready():
	pass # Replace with function body.


func _on_start_press():
	get_tree().change_scene_to(game_scene)


func _on_exit_press():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
