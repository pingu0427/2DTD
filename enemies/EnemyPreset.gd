extends CharacterBody2D

var speed = 100  # The speed at which the enemy moves
var direction = Vector2.ZERO

func _physics_process(_delta):
	# Move towards the castle
	var tower = get_tree().get_nodes_in_group("towers")[0]  # Get the castle from the group
	var _direction = (tower.position - position).normalized()
	$AnimatedSprite2D.play("move")
	move_and_slide()
