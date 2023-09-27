extends RigidBody2D

var attackRange = 30  # The range at which the tower can attack enemies
var attackDamage = 10  # The amount of damage the tower does to enemies

var projectile_scene = load("res://projectiles/Projectile.tscn")

func _process(delta):
	# Attack any enemies within range
	for enemy in get_tree().get_nodes_in_group("enemies"):
		if position.distance_to(enemy.position) <= attackRange:
			enemy.take_damage(attackDamage)

func is_enemy_in_range():
	for enemy in get_tree().get_nodes_in_group("enemies"):
		if position.distance_to(enemy.position) <= attackRange:
			return true
	return false

func shoot_projectile_at(enemy):
	var projectile = projectile_scene.instance()
	projectile.position = position
	projectile.direction = (enemy.position - position).normalized()
	get_parent().add_child(projectile)

func _physics_process(delta):
	for enemy in get_tree().get_nodes_in_group("enemies"):
		if position.distance_to(enemy.position) <= attackRange:
			shoot_projectile_at(enemy)
