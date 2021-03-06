extends Control

const START_ANCHOR = Vector2(0.5, 0.25)
const OFFSET_ANCHOR = Vector2(0, 0.1)

onready var list_bg = $list_bg

var quest_scene = preload("res://scenes/Quest_item.tscn")

var quests = ["Find sword", "Kill monsters attacking the village"]

var quest_instances = []
var quest_done_index = -1

func _ready():
	for i in range(0, quests.size()):
		var quest = quests[i]
		
		var instance = quest_scene.instance()
		instance.visible = false
		list_bg.add_child(instance)
		quest_instances.append(instance)
		
		instance.set_text(quest)
		
		var extra_space = 0
		if i - 1 >= 0:
			var prev_quest = quest_instances[i - 1]
			var prev_line_count = prev_quest.get_line_count()
			var current_line_count = instance.get_line_count()
			if prev_line_count > 1 or current_line_count > 1:
				var line_count = max(prev_line_count, current_line_count)
				extra_space = line_count - 1
		
		instance.anchor_left = START_ANCHOR.x
		instance.anchor_right = START_ANCHOR.x
		instance.anchor_top = START_ANCHOR.y + (i + extra_space) * OFFSET_ANCHOR.y
		instance.anchor_bottom = START_ANCHOR.y + (i + extra_space) * OFFSET_ANCHOR.y

func _on_quests_received():
	for quest in quest_instances:
		quest.visible = true
	
	var chests = get_tree().get_nodes_in_group("chests")
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_chest_index = rng.randi_range(0, chests.size() - 1)
	for i in range(0, chests.size()):
		var chest = chests[i]
		chest.enable_chest(i == random_chest_index)

func update_quests():
	quest_done_index += 1
	quest_instances[quest_done_index].visible = false
