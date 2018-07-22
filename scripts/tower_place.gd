extends Sprite

export(PackedScene) var construction_menu

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var menu = get_node("/root/game/ui/construction_menu")
		menu.open()
		
		menu.rect_position = global_position
		if menu.rect_position.x <= 32:
			menu.rect_position.x += 32
		if menu.rect_position.x >= 800:
			menu.rect_position.x -= 32
		if menu.rect_position.y <= 32:
			menu.rect_position.y += 160
		
		menu.tower_place = self

func _on_Area2D_mouse_entered():
	self_modulate = Color(0, 0, 1, 1)

func _on_Area2D_mouse_exited():
	self_modulate = Color(1, 1, 1, 1)
	var menu = get_node("/root/game/ui/construction_menu")
	menu.hide()
