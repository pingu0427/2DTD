extends RigidBody2D

var attackRange = 100  # The range at which the tower can attack enemies
var attackDamage = 10  # The amount of damage the tower does to enemies

var projectile_scene = load("res://projectiles/ProjectilePreset.tscn")

func _ready():
	$AnimatedSprite2D.play("idle")

func _process(_delta):
	# Attack any enemies within range
	var nearest_enemy = get_nearest_enemy()
	if nearest_enemy and position.distance_to(nearest_enemy.position) <= attackRange:
		shoot_projectile_at(nearest_enemy)

func get_nearest_enemy():
	var nearest_enemy = null
	var nearest_distance = INF
	for enemy in get_tree().get_nodes_in_group("enemies"):
		var distance = position.distance_to(enemy.position)
		if distance < nearest_distance:
			nearest_distance = distance
			nearest_enemy = enemy
	return nearest_enemy


func shoot_projectile_at(enemy):
	var projectile = projectile_scene.instance()
	projectile.position = position
	projectile.direction = (enemy.position - position).normalized()
	get_parent().add_child(projectile)

func _physics_process(_delta):
	for enemy in get_tree().get_nodes_in_group("enemies"):
		if position.distance_to(enemy.position) <= attackRange:
			shoot_projectile_at(enemy)
