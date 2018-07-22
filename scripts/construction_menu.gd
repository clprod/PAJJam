extends Control

export(PackedScene) var projectile_tower_base
export(PackedScene) var aoe_tower_base

export(int) var projectile_tower_price = 10
export(int) var aoe_tower_price = 8

var tower_place

func _ready():
	$Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer/proj_price_container/proj_price_label.text = str(projectile_tower_price)
	$Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer2/aoe_price_container/aoe_price_label.text = str(aoe_tower_price)

func open():
	if get_node("/root/game").wood_nb < projectile_tower_price:
		$Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer/proj_button.disabled = true
		$Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer.modulate = Color(1, 0, 0, 0.7)
	else:
		$Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer/proj_button.disabled = false
		$Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer.modulate = Color(1, 1, 1, 1)

	if get_node("/root/game").wood_nb < aoe_tower_price:
		$Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer2/aoe_button.disabled = true
		$Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer2.modulate = Color(1, 0, 0, 0.7)
	else:
		$Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer2/aoe_button.disabled = false
		$Control/Panel/VBoxContainer/HBoxContainer/VBoxContainer2.modulate = Color(1, 1, 1, 1)

	show()

func _on_proj_button_pressed():
	place_tower(projectile_tower_base.instance())
	get_node("/root/game").change_wood(-projectile_tower_price)
	hide()
	remove_tower_place()

func _on_aoe_button_pressed():
	place_tower(aoe_tower_base.instance())
	get_node("/root/game").change_wood(-aoe_tower_price)
	hide()
	remove_tower_place()

func place_tower(tower):
	tower.position = tower_place.position
	get_node("/root/game/towers").add_child(tower)
	
func remove_tower_place():
	tower_place.queue_free()