extends Node2D

signal durability_changed(new, maximum)

export(bool) var aoe = false
export(float) var attack_cooldown = 1
export(int) var durability = 10
var attack_timer = 0

var show_infos = false
var current_durability
var durability_control

export(PackedScene) var projectile_scene

func _ready():
	current_durability = durability

func _process(delta):
	attack_timer -= delta
	if attack_timer <= 0 and $Area2DRange.get_overlapping_areas().size() > 0:
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

func attack_all():
	print("attack all")
	for e in $Area2DRange.get_overlapping_areas():
		e.get_parent().take_damages(5)

func attack_one():
	print("attack one")
	var to_attack = find_last()
	
	var projectile = projectile_scene.instance()
	print(projectile)
	get_node("/root/game/towers").add_child(projectile)
	projectile.global_position = self.global_position
	projectile.direction = (to_attack.global_position - self.global_position).normalized()
	
	# TODO : faire un signal projectil <==> enemi
	#to_attack.take_damages(5)

func destroy_tower():
	print("tower destroyed")
	if durability_control != null:
		durability_control.hide()
		disconnect("durability_changed", durability_control, "set_durability")
	queue_free()

func find_last():
	if $Area2DRange.get_overlapping_areas().size() <= 0:
		return null
	var last = $Area2DRange.get_overlapping_areas()[0].get_parent()
	for e in $Area2DRange.get_overlapping_areas():
		if e.get_parent().offset > last.offset:
			last = e.get_parent()
	return last

func _draw():
	if aoe:
		draw_circle(Vector2(), 16, Color(0, 0, 1))
	else:
		draw_circle(Vector2(), 16, Color(0, 0.3, 0.3))
	
	if show_infos:
		draw_circle(Vector2(), $Area2DRange/CollisionShape2D.shape.radius, Color(0, 1, 0, 0.1))

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