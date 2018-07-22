extends Control

func play_anim():
	$AnimationPlayer.play("show2")

func close():
	$AnimationPlayer.play("hide")