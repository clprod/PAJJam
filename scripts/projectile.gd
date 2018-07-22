extends KinematicBody2D

var speed = 350
var velocity = Vector2()
var direction = Vector2()

func _process(delta):
	velocity = direction * speed * delta
	var collision = move_and_collide(velocity)
	if collision != null:
		collision.collider.get_parent().take_damages(5)
		queue_free()
	if global_position.x < 0 || global_position.y < 0 || global_position.x > Globals.get("display/width") || global_position.y > Globals.get("display/heigh"):
		queue_free()

func _draw():
	draw_circle(Vector2(), 6, Color(1, 0, 1))