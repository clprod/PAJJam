extends Node2D

signal durability_changed(new, maximum)

export(String) var original_scene = ""
export(String) var fire_scene = ""
export(String) var ice_scene = ""

export(bool) var aoe = false
export(float) var attack_cooldown = 1
export(float) var damages = 5
export(int) var durability = 10
export(PackedScene) var ruin_scene
var attack_timer = 0

var show_infos = false
var current_durability
var durability_control

export(PackedScene) var projectile_scene

var atack_sound
var construction_sound
var destroy_sound

func _ready():
	atack_sound = get_node("atack_sound")
	construction_sound = get_node("construct_sound")
	destroy_sound = get_node("destroy_sound")
	construction_sound.play()
	current_durability = durability
	if not aoe:
		$Sprite/Sprite.rotate(deg2rad(randi() % 360))

func _process(delta):
	attack_timer -= delta
	if attack_timer <= 0 and $Area2DRange.get_overlapping_bodies().size() > 0:
		$AnimationPlayer.play("attack")
		if aoe:
			attack_all()
		else:
			attack_one()
		attack_timer = attack_cooldown
		current_durability -= 1
		emit_signal("durability_changed", current_durability, durability)
		if current_durability <= 0:
			destroy_tower()

	if not aoe:
		var target = find_last()
		if target != null:
			$Sprite/Sprite.look_at(target.position)
			$Sprite/Sprite.rotate(deg2rad(90))

	if durability_control != null:
		durability_control.rect_position = get_global_mouse_position()
		if durability_control.visible == false:
			durability_control.show()

func attack_all():
	for e in $Area2DRange.get_overlapping_bodies():
		e.get_parent().take_damages(damages)

func attack_one():
	var to_attack = find_last()
	
	var projectile = projectile_scene.instance()
	get_node("/root/game").add_child(projectile)
	atack_sound.play()
	projectile.global_position = global_position
	projectile.damages = damages
	projectile.direction = (to_attack.global_position - global_position).normalized()

func destroy_tower():
	destroy_sound.play()
	if durability_control != null:
		disconnect("durability_changed", durability_control, "set_durability")
		durability_control.hide()
		durability_control = null
	var ruins = ruin_scene.instance()
	get_node("/root/game/towers").add_child(ruins)
	ruins.position = position
	ruins.original_tower = original_scene
	ruins.fire_tower = fire_scene
	ruins.ice_tower = ice_scene

	queue_free()

func find_last():
	if $Area2DRange.get_overlapping_bodies().size() <= 0:
		return null
	var last = $Area2DRange.get_overlapping_bodies()[0].get_parent()
	for e in $Area2DRange.get_overlapping_bodies():
		if e.get_parent().offset > last.offset:
			last = e.get_parent()
	return last

func _draw():
	if aoe:
		draw_circle(Vector2(), 16, Color(0, 0, 1))
	
	if show_infos:
		draw_circle(Vector2(), $Area2DRange/CollisionShape2D.shape.radius, Color(1, 0, 0, 0.2))

func _on_Area2D2_mouse_entered():
	show_infos = true
	update()
	durability_control = get_node("/root/game/ui/durability_text")
	durability_control.set_durability(current_durability, durability)
	connect("durability_changed", durability_control, "set_durability")
	durability_control.show()

func _on_Area2DBody_mouse_exited():
	show_infos = false
	update()
	durability_control.hide()
	disconnect("durability_changed", durability_control, "set_durability")
	durability_control = null