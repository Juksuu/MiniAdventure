extends YSort

signal all_enemies_killed

const ENEMY_AMOUNT = 5

onready var crab_enemy = preload("res://scenes/Crab_enemy.tscn")
onready var spawn_area_shape = $spawn_area/CollisionShape2D
onready var spawn_area = $spawn_area

var enemies_killed = 0

func _ready():
	var spawn_area_size = Vector2(spawn_area_shape.shape.extents.x, spawn_area_shape.shape.extents.y)
	var spawn_area_start = Vector2(
		spawn_area.position.x - spawn_area_size.x / 2,
		spawn_area.position.y - spawn_area_size.y / 2)
		
	var rng = RandomNumberGenerator.new()
	var lastPos = Vector2(0, 0)
	for i in range(0, ENEMY_AMOUNT):
		var enemy = crab_enemy.instance()
		add_child(enemy)
		enemy.connect("crab_killed", self, "_enemy_killed")
		
		var enemy_size = enemy.get_size()
		
		var pos = spawn_area_start + Vector2(
			rng.randi_range(spawn_area_start.x, spawn_area_size.x),
			 rng.randi_range(spawn_area_start.y, spawn_area_size.y))
		
		while abs(lastPos.x - pos.x) <= enemy_size.x and abs(lastPos.y - pos.y) <= enemy_size.y:
			pos = spawn_area_start + Vector2(
				rng.randi_range(spawn_area_start.x, spawn_area_size.x),
				rng.randi_range(spawn_area_start.y, spawn_area_size.y))
		
		lastPos = pos
		enemy.position = pos

func _enemy_killed():
	enemies_killed += 1
	if enemies_killed >= ENEMY_AMOUNT:
		get_tree().call_group("hud", "update_quests")
		emit_signal("all_enemies_killed")
