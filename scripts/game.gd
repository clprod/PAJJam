extends Node2D

var waves = [
[[1, 1], [1, 4], [1, 7]],
[[1, 1], [1, 2.5], [1, 4], [1, 5.5], [1, 7]],
[[1, 1], [1, 1.5], [1, 2], [1, 4], [1, 4.5], [1, 5], [1, 7], [1, 7.5], [1, 8]],
[[1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7], [1, 8], [1, 9]],
[[1, 1], [1, 1.5], [1, 2], [1, 2.5], [1, 3], [1, 4], [1, 4.5], [1, 5], [1, 5.5] , [1, 6]],
[[1, 1], [1, 1.25], [1, 1.5], [1, 2], [1, 2.25], [1, 2.5], [1, 4], [1, 4.25], [1, 4.5] , [1, 5], [1, 6], [1, 7]],
[[1, 1], [1, 1.5], [1, 2], [1, 2.5], [1, 3], [1, 4], [1, 4.5], [1, 5], [1, 5.5], [1, 6], [1, 10], [1, 11.5], [1, 12], [1, 12.5], [1, 13], [1, 14], [1, 14.5], [1, 15], [1, 15.5] , [1, 16]],
[[1, 1], [1, 1.25], [1, 1.5], [1, 2], [1, 2.25], [1, 2.5], [1, 4], [1, 4.25], [1, 4.5], [1, 5], [1, 6], [1, 7], [1, 10], [1, 11.25], [1, 11.5], [1, 12], [1, 12.25], [1, 12.5], [1, 14], [1, 14.25], [1, 14.5] , [1, 15], [1, 16], [1, 17]],
]

export(PackedScene) var enemy_scene
var spawn_timer = 0

var wood_nb = 10
var fire_nb = 0
var ice_nb = 0

var current_wave
var playing = false

var life_nb = 3

signal wood_changed(amount)
signal fire_changed(amount)
signal ice_changed(amount)

func _ready():
	randomize()
	emit_signal("wood_changed", wood_nb)
	emit_signal("fire_changed", fire_nb)
	emit_signal("ice_changed", ice_nb)
	current_wave = 0

func _process(delta):
	if life_nb <= 0 :
		print("End Game : no more lives")
	
	if playing == false: # Between two waves
		if Input.is_action_just_pressed("ui_accept"): # start next wave
			playing = true
			get_node("map2").play_anim("hide_places")
			print("Start wave")
	else:
		if current_wave >= waves.size() or waves[current_wave].size() <= 0: # no more enemies to spawn
			if get_tree().get_nodes_in_group("enemies").size() <= 0: # and no more enemies running
				current_wave += 1
				spawn_timer = 0
				playing = false
				if current_wave >= waves.size():
					print("End Game")
				else:
					print("End wave: press enter to start new wave")
					get_node("map2").play_anim("show_places")
			return

		spawn_timer += delta
		if spawn_timer >= waves[current_wave][0][1]:
			var enemy = enemy_scene.instance()
			enemy.speed = 50
			get_node("map2").add_child(enemy)
			waves[current_wave].remove(0)

func change_wood(amount):
	wood_nb += amount
	emit_signal("wood_changed", wood_nb)

func change_fire(amount):
	fire_nb += amount
	emit_signal("fire_changed", fire_nb)

func change_ice(amount):
	ice_nb += amount
	emit_signal("ice_changed", ice_nb)