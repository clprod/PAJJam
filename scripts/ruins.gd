extends Sprite

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("click on ruin")

func _on_Area2D_mouse_entered():
	self_modulate = Color(0, 0, 1, 0.5)

func _on_Area2D_mouse_exited():
	self_modulate = Color(1, 1, 1, 1)
