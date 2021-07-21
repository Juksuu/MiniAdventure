extends Area2D

var player = null

func is_player_in_area() -> bool:
	return player != null and not player.dead

func _on_player_entered(body):
	player = body

func _on_player_exited(body):
	player = null
