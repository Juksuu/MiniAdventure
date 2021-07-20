extends Control

const START_ANCHOR = Vector2(0.5, 0.25)
const OFFSET_ANCHOR = Vector2(0, 0.1)

onready var list_bg = $list_bg

var quest_scene = preload("res://scenes/Quest_item.tscn")

var quests = ["Find sword", "Kill monsters attacking the village"]

var quest_intances = []

func _ready():
	for i in range(0, quests.size()):
		var quest = quests[i]
		
		var instance = quest_scene.instance()
		instance.visible = false
		list_bg.add_child(instance)
		quest_intances.append(instance)
		
		instance.set_text(quest)
		
		var extra_space = 0
		if i - 1 >= 0:
			var prev_quest = quest_intances[i - 1]
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
	for quest in quest_intances:
		quest.visible = true
