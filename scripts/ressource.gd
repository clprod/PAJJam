extends Control

func set_amount(amount):
	$Panel/Label.text = "x" + str(amount)
	if amount >= 1:
		unlock()

func unlock():
	$Panel/TextureRect.self_modulate = Color(1, 1, 1, 1)