extends CharacterBody2D

var speed = 500  # The speed of the projectile
var direction = Vector2.ZERO  # The direction the projectile is moving in

func _physics_process(delta):
	var velocity = direction * speed
	velocity = move_and_slide()
