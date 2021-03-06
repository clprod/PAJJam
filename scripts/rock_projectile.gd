extends "res://scripts/projectile.gd"

func _ready():
	get_node("explosions")
	get_node("explosions").set_emitting(false)
	get_node("explosions/Timer").wait_time = 0.18

func on_hit():
	speed = 0
	get_node("Sprite").set_visible(false)
	get_node("CollisionShape2D").disabled = true
	get_node("explosions").set_emitting(true)
	get_node("explosions/Timer").start()


func _on_Timer_timeout():
	.on_hit()
