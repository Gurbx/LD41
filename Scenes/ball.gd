extends RigidBody2D

signal shot_fired
signal damage_taken
signal crystal_picked

export (int) var damage

var damages_enemies = false

var can_select = false
var can_shoot = false
var shoot_mode_active = false
var force #Shot force
var MAX_FORCE = 700
var MIN_FORCE = 30
#var player
var shake_amount = 0

var can_be_damaged = true

func _ready():
	pass
	#player = get_parent().get_node("player")

func _process(delta):
	$glow.global_rotation = 0
	#Hanlde damage vel
	damages_enemies = true
	if abs(linear_velocity.x) < 300 and abs(linear_velocity.y) < 300:
		damages_enemies = false
	$fire.emitting = damages_enemies
	
	if Input.is_mouse_button_pressed(1) && can_select && can_shoot:
		shoot_mode_active = true
	
	if (shoot_mode_active):
		handle_shooting(delta)
	
	#CAMERA SHAKE
	$camera.set_offset(Vector2(rand_range(-1.0, 1.0) * shake_amount, rand_range(-1.0, 1.0) * shake_amount))
	shake_amount -= delta * 50
	if (shake_amount < 0): shake_amount = 0
	
	#var distance_from_player = player.position.distance_to(position)
	#if (distance_from_player <= 30 && can_shoot):
	#	player.call("toggle_shooting", true)
	#	player.position = position
	#	queue_free()

func stop():
	linear_velocity = -linear_velocity*0.25

func _on_ball_body_entered(body):
	$bounce.play()
	$Hit.restart()
	shake_amount = 10
	if body.has_method("damage_player") && !damages_enemies && can_be_damaged:
		damage()
		print("damage taken")
	elif body.has_method("hit_by_player"):
		body.call("hit_by_player", damage)
	elif body.has_method("_break"):
		if (damages_enemies): body.call("_break")

func damage():
	if (can_be_damaged == false): return
	$damaged.play()
	shake_amount = 10
	emit_signal("damage_taken")

func _on_pickupTimer_timeout():
	can_shoot = true

func can_enter_hole():
	if abs(linear_velocity.x) < 150 and abs(linear_velocity.y) < 150:
		return true
	return false

func _draw():
	if (shoot_mode_active):
		var point1 = Vector2(0,0)
		var point2 = get_local_mouse_position()
		force = point1.distance_to(point2)*3.5
		if (force > MAX_FORCE): force = MAX_FORCE
		var color = Color(force/MAX_FORCE, 1-force/MAX_FORCE, 0)
		draw_line(point1, point2, color, 5)
		draw_circle(point2, 8, color)
		draw_circle(point1, 18, color)


func handle_shooting(delta):
	if Input.is_action_pressed("shoot"):
		update()
	if Input.is_action_just_released("shoot"):
		if (force < MIN_FORCE):
			shoot_mode_active = false
			update()
			force = 0
			return

		#var targetPosition = position - get_local_mouse_position()
		#var direction = targetPosition-position
		var direction = (get_global_mouse_position() - global_position).normalized()
		apply_impulse(Vector2(0,0), -direction*force)
		shoot_mode_active = false
		can_shoot = false
		force = 0
		$readyTimer.start()
		$launch.play()
		emit_signal("shot_fired")
		update()

func _on_ClickableArea_mouse_entered():
	can_select = true

func _on_ClickableArea_mouse_exited():
	can_select = false

func pick_crystal():
	emit_signal("crystal_picked")

func set_can_be_damaged(b):
	can_be_damaged = b
