extends Node2D

export(PackedScene) var enemy_scene
var spawn_timer = 0

func _process(delta):
	spawn_timer -= delta
	if spawn_timer <= 0:
		var enemy = enemy_scene.instance()
		enemy.speed = 50
		get_node("map2").add_child(enemy)
		spawn_timer = 2