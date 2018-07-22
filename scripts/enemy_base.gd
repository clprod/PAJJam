extends PathFollow2D

export(float) var speed = 0
export(float) var health = 10

var burning = false
var slowed = false

export(float) var burn_cooldown = 0.6
var burn_timer = 0

func _process(delta):
	offset += speed * delta
	if unit_offset >= 1:
		get_node("/root/game").life_nb -= 1
		queue_free()

	if burning:
		burn_timer += delta
		if burn_timer >= burn_cooldown:
			take_damages(1)
			burn_timer = 0

func take_damages(amount):
	health -= amount
	if health <= 0:
		var game = get_node("/root/game")
		game.change_wood(4)
		if randi() % 100 <= 100:
			if randi() % 2 == 0:
				game.change_fire(1)
			else:
				game.change_ice(1)
		queue_free()
	else:
		$AnimationPlayer.play("hit")

func slow():
	if not slowed:
		slowed = true
		speed /= 2
	burning = false

func burn():
	burning = true
	if slowed:
		speed *= 2
	slowed = false