extends KinematicBody2D

var speed = 10
var velocity = Vector2()
var direction = Vector2()

func _ready():
	print("Creation d'un projectile")
	pass

func _process(delta):
	velocity = direction * speed * delta
	var collision = move_and_collide(velocity * delta)
	if collision != null:
		queue_free()
		# TODO : faire des signaux projectiles <==> enemy

func _draw():
	draw_circle(Vector2(position), 12, Color(1, 0, 1))