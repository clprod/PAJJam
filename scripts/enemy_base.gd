extends PathFollow2D

export(float) var speed = 0
export(float) var health = 10

func _process(delta):
	offset += speed * delta
	if unit_offset >= 1:
		queue_free()

func _draw():
	draw_circle(Vector2(), 16, Color(1, 0, 0))

func take_damages(amount):
	health -= amount
	if health <= 0:
		var game = get_node("/root/game")
		game.change_wood(5)
		if randi() % 100 <= 3:
			game.change_fire(1)
			game.change_ice(1)
		queue_free()