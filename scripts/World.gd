extends Node2D

onready var map = $Map_container/Map
onready var map_container = $Map_container

onready var ysort = $YSort
onready var player = $YSort/Player
onready var tavern = $YSort/Tavern
onready var tavern_inside = $YSort/Tavern_inside

func _ready():
	ysort.remove_child(tavern_inside)

func _on_Tavern_tavern_entered():
	ysort.add_child(tavern_inside)
	
	map_container.remove_child(map)
	ysort.remove_child(tavern)


func _on_Tavern_inside_tavern_exit():
	ysort.remove_child(tavern_inside)
	
	map_container.add_child(map)
	ysort.add_child(tavern)