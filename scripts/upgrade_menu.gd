extends Control

export(int) var repair_price = 6

var ruins
var original_tower = ""
var fire_tower = ""
var ice_tower = ""

func open():
	show()
	$Control/Panel/HBoxContainer/repair_container/repair_price_container/repair_price_label.text = str(repair_price)
	if get_node("/root/game").wood_nb < repair_price:
		$Control/Panel/HBoxContainer/repair_container/repair_price_container.modulate = Color(1, 0, 0, 0.7)
		$Control/Panel/HBoxContainer/repair_container/repair_price_container/repair_button.disabled = true
	else:
		$Control/Panel/HBoxContainer/repair_container/repair_price_container.modulate = Color(1, 1, 1, 1)
		$Control/Panel/HBoxContainer/repair_container/repair_price_container/repair_button.disabled = false

	if fire_tower == "":
		print("no fire tower")
		$Control/Panel/HBoxContainer/upgrade_container/HBoxContainer/fire_button.self_modulate = Color(0, 0, 0, 0.5)
		$Control/Panel/HBoxContainer/upgrade_container/HBoxContainer/fire_button.disabled = true
	elif get_node("/root/game").fire_nb < 1:
		print("not enough tower")
		$Control/Panel/HBoxContainer/upgrade_container/HBoxContainer/fire_button.self_modulate = Color(1, 0, 0, 0.7)
		$Control/Panel/HBoxContainer/upgrade_container/HBoxContainer/fire_button.disabled = true
	else:
		$Control/Panel/HBoxContainer/upgrade_container/HBoxContainer/fire_button.self_modulate = Color(1, 1, 1, 1)
		$Control/Panel/HBoxContainer/upgrade_container/HBoxContainer/fire_button.disabled = false

	if ice_tower == "":
		$Control/Panel/HBoxContainer/upgrade_container/HBoxContainer/ice_button.self_modulate = Color(0, 0, 0, 0.7)
		$Control/Panel/HBoxContainer/upgrade_container/HBoxContainer/ice_button.disabled = true
	elif get_node("/root/game").ice_nb < 1:
		$Control/Panel/HBoxContainer/upgrade_container/HBoxContainer/ice_button.self_modulate = Color(1, 0, 0, 0.7)
		$Control/Panel/HBoxContainer/upgrade_container/HBoxContainer/ice_button.disabled = true
	else:
		$Control/Panel/HBoxContainer/upgrade_container/HBoxContainer/ice_button.self_modulate = Color(1, 1, 1, 1)
		$Control/Panel/HBoxContainer/upgrade_container/HBoxContainer/ice_button.disabled = false

func _on_repair_button_pressed():
	place_tower(load(original_tower).instance())
	get_node("/root/game").change_wood(-repair_price)
	hide()
	remove_ruins()

func _on_fire_button_pressed():
	pass # replace with function body

func _on_ice_button_pressed():
	pass # replace with function body

func place_tower(tower):
	tower.position = ruins.position
	get_node("/root/game/towers").add_child(tower)

func remove_ruins():
	ruins.queue_free()