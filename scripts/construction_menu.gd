extends Control

export(PackedScene) var projectile_tower_base
export(PackedScene) var aoe_tower_base

var tower_place

func _on_proj_button_pressed():
	place_tower(projectile_tower_base.instance())
	hide()
	remove_tower_place()

func _on_aoe_button_pressed():
	place_tower(aoe_tower_base.instance())
	hide()
	remove_tower_place()

func place_tower(tower):
	tower.position = tower_place.position
	get_node("/root/game/towers").add_child(tower)
	get_node("/root/game").change_wood(-10)
	
func remove_tower_place():
	tower_place.queue_free()