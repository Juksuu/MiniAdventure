extends Control

var game_scene = preload("res://scenes/World.tscn")
var credits_scene = preload("res://scenes/Credits.tscn")

func _on_start_press():
	get_tree().change_scene_to(game_scene)


func _on_exit_press():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


func _on_credits_pressed():
	get_tree().change_scene_to(credits_scene)
