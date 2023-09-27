extends Node2D

var gridSize = 5
var grid = []
var castle = preload("res://castle.tscn")
var towerPreset = preload("res://towers/TowerPreset.tscn")
var enemyPreset = preload("res://enemies/EnemyPreset.tscn")
var upgradePopupPreset = preload("res://popup_menu.tscn")

var chunk_size = 16  # The size of each map chunk in tiles
var loaded_chunks = {}  # A dictionary to keep track of the loaded chunks

var xp = 0

@export var enemy_spawn_points = [Vector2(50, 50), Vector2(-50, 50), Vector2(-50, -50), Vector2(50, -50)]
@export var castle_position = Vector2.ZERO
@export var castle_hp = 500

func generate_chunk(chunk_position):
	var chunk = TileMap.new()
	# Fill the chunk with tiles...
	loaded_chunks[chunk_position] = chunk

func update_chunks(player_position):
	var player_chunk_position = player_position / chunk_size
	for chunk_position in loaded_chunks.keys():
		if chunk_position.distance_to(player_chunk_position) > 2:
			loaded_chunks[chunk_position].queue_free()
			loaded_chunks.erase(chunk_position)
	for x in range(-2, 3):
		for y in range(-2, 3):
			var chunk_position = player_chunk_position + Vector2(x, y)
			if not loaded_chunks.has(chunk_position):
				generate_chunk(chunk_position)

func _ready():
	# Load your enemy and tower presets
	enemyPreset = load("res://enemies/EnemyPreset.tscn")
	towerPreset = load("res://towers/TowerPreset.tscn")
	# Initialize your grid and castle
	initializeGrid()
	castle.position = Vector2.ZERO  # Assuming the castle is at grid position (0, 0)
	check_xp()
	for point in enemy_spawn_points:
		var enemy = enemyPreset.instantiate()
		enemy.position = point
		enemy.set_target(castle_position)
		add_child(enemy)

func initializeGrid():
	# Initialize your grid based on gridSize
	for i in range(gridSize * 2 - 1):
		var row = []
		var tilesInRow = gridSize - abs(gridSize - 1 - i)  # Calculate the number of tiles in this row
		for j in range(tilesInRow):
			row.append(null)  # Initially, all grid spaces are empty
		grid.append(row)

func spawnEnemy(direction):
	# Spawn an enemy at a random location on the grid
	var enemy = enemyPreset.instantiate()
	enemy.direction = direction
	add_child(enemy)

func spawnTower():
	# Spawn a tower at a random location on the grid
	var tower = towerPreset.instantiate()
	add_child(tower)


func _on_enemy_timer_timeout():
	spawnEnemy(Vector2(0, -100))  # Spawn an enemy from the top
	spawnEnemy(Vector2(0, 100))  # Spawn an enemy from the bottom
	
func check_xp():
	if xp % 500 == 0 and xp > 0:   # check XP, triggered when XP hits 500, 1000, 1500 and so on
		var upgradePopup = upgradePopupPreset.instantiate()
		add_child(upgradePopup)
		upgradePopup.popup_centered()
