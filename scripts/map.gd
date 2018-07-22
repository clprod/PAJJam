extends Path2D

func play_anim(anim):
	$AnimationPlayer.play(anim)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hide_places":
		$tower_places.hide()


func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name == "show_places":
		$tower_places.show()
