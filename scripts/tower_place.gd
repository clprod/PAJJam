extends Sprite

export(PackedScene) var projectile_tower_base
export(PackedScene) var aoe_tower_base

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var tower
		if randi() % 100  < 50:
			tower = aoe_tower_base.instance()
		else:
			tower = projectile_tower_base.instance()
		tower.position = position
		get_node("/root/game/towers").add_child(tower)
		get_node("/root/game").change_wood(-10)
		queue_free()

func _on_Area2D_mouse_entered():
	self_modulate = Color(0, 0, 1, 1)

func _on_Area2D_mouse_exited():
	self_modulate = Color(1, 1, 1, 1)
