extends KinematicBody2D

signal shot_fired

var velocity = Vector2()
var shoot_mode_active = false
const WALK_SPEED = 120
var force #Shot force
var MAX_FORCE = 500


func _physics_process(delta):
	if (!shoot_mode_active):
		handle_movement(delta) 
	else:
		handle_shooting(delta)

func handle_movement(delta):
	velocity = move_and_slide(velocity)
	var target_speed = Vector2()
	if Input.is_action_pressed("ui_up"):
		target_speed.y += -1
	if Input.is_action_pressed("ui_down"):
		target_speed.y += 1
	if Input.is_action_pressed("ui_left"):
		target_speed.x += -1
	if Input.is_action_pressed("ui_right"):
		target_speed.x += 1
	target_speed = target_speed.normalized()
	target_speed *= WALK_SPEED
	velocity.x= lerp(velocity.x, target_speed.x, 0.25)
	velocity.y = lerp(velocity.y, target_speed.y, 0.25)
	

func _draw():
	if (shoot_mode_active):
		var targetPosition = position + get_local_mouse_position()
		var point1 = Vector2(0,4)
		var point2 = get_local_mouse_position()/2
		force = point1.distance_to(point2)*3
		if (force > MAX_FORCE): force = MAX_FORCE
		var color = Color(force/MAX_FORCE, 1-force/MAX_FORCE, 0)
		draw_line(point1, point2, color, 5)
		draw_circle(point2, 8, color)
		draw_circle(point1, 18, color)

func handle_shooting(delta):
	if Input.is_action_pressed("shoot"):
		update()
	if Input.is_action_just_released("shoot"):
		var bullet = preload("res://ball.tscn").instance()
		var targetPosition = position - get_local_mouse_position()
		bullet.position = position + (targetPosition - position).normalized() * 26 #use node for shoot position
		bullet.shoot((targetPosition-position), force)
		get_parent().add_child(bullet) #don't want bullet to move with me, so add it as child of parent
		shoot_mode_active = false
		update()
		emit_signal("shot_fired")

func toggle_shooting(b):
	shoot_mode_active = b