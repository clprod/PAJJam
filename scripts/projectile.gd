extends KinematicBody2D

export(bool) var is_fire = false
export(bool) var is_ice = false

var speed = 350
var damages
var velocity = Vector2()
var direction = Vector2()

func _process(delta):
	velocity = direction * speed * delta
	var collision = move_and_collide(velocity)
	if collision != null:
		var enemy = collision.collider.get_parent()
		enemy.take_damages(damages)
		if is_fire:
			enemy.burn()
		elif is_ice:
			enemy.slow()
		on_hit()
	if global_position.x < 0 || global_position.y < 0 || global_position.x > get_viewport().size.x || global_position.y > get_viewport().size.y:
		queue_free()

func on_hit():
	queue_free()

#func _draw():
#	draw_circle(Vector2(), 6, Color(1, 0, 1))