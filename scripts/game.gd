extends Node2D

export(PackedScene) var enemy_scene
var spawn_timer = 0

var wood_nb = 25
var fire_nb = 0
var ice_nb = 0

signal wood_changed(amount)
signal fire_changed(amount)
signal ice_changed(amount)

func _ready():
	emit_signal("wood_changed", wood_nb)
	emit_signal("fire_changed", fire_nb)
	emit_signal("ice_changed", ice_nb)

func _process(delta):
	spawn_timer -= delta
	if spawn_timer <= 0:
		var enemy = enemy_scene.instance()
		enemy.speed = 50
		get_node("map2").add_child(enemy)
		spawn_timer = 2

func change_wood(amount):
	wood_nb += amount
	emit_signal("wood_changed", wood_nb)

func change_fire(amount):
	fire_nb += amount
	emit_signal("fire_changed", fire_nb)

func change_ice(amount):
	ice_nb += amount
	emit_signal("ice_changed", ice_nb)