extends Control

func set_durability(current, maximum):
	$Panel/Label.text = "Durability: " + str(current) + "/" + str(maximum)