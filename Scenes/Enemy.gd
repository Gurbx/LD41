extends KinematicBody2D

signal died

var chasePlayer = false
var playing_aggro = false
var dead = false
var crystal_scene = preload("res://Scenes/Crystal.tscn")

export(int) var health

var speed = 50
var player_body

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var anim = get_node("AnimationPlayer").get_animation("float")
	anim.set_loop(true)
	get_node("AnimationPlayer").play("float")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func damage_player():
	return !dead

func _physics_process(delta):
	if (chasePlayer): handle_chase(delta)
	elif(!playing_aggro): $AnimatedSprite.play("default")

func handle_chase(delta):
	#MOVEMENT
	var player_position = player_body.get_position()
	var direction = (player_position - position).normalized()
	var motion = Vector2()
	motion += direction * delta * speed
	position += motion
	
	#ANIMATION
	if (!playing_aggro):
		if (direction.y < 0):
			$AnimatedSprite.play("turn_up")
		elif(direction.x < 0):
			$AnimatedSprite.play("turn_left")
		else:
			$AnimatedSprite.play("turn_right")
	
	#RAYCAST
	#var space_state = get_world_2d().direct_space_state
	#var result = space_state.intersect_ray(global_position, player_position, [self])
	#if result:
	#	pass
		#print("Hit at point: ", result.position)
	

func hit_by_player(damage):
	health -= damage
	if (health <= 0): 
		$death.play()
		$CollisionShape2D.visible = false
		emit_signal("died")
		$death_timer.start()
		$shadow.visible = false
		$AnimatedSprite.visible = false
		dead = true
		$Hit.emitting = true
		$Hit.restart()
		drop_crystals()

func drop_crystals():
	randomize()
	for i in range (0,4):
		var crystal = crystal_scene.instance()
		get_parent().add_child(crystal)
		var crys_pos = global_position
		crys_pos.x = crys_pos.x + rand_range(-15, 15)
		crys_pos.y = crys_pos.y + rand_range(-15, 15)
		crystal.global_position = crys_pos

func _on_aggroMarker_player_in_range(body):
	$aggro.play()
	chasePlayer = true
	playing_aggro = true
	$aggroTimer.start()
	$AnimatedSprite.play("aggro")
	player_body = body

func _on_aggroMarker_player_out_of_range():
	chasePlayer = false
	playing_aggro = true
	$deaggroTimer.start()
	$AnimatedSprite.play("deaggro")


func _on_aggroTimer_timeout():
	playing_aggro = false

func _on_deaggroTimer_timeout():
	playing_aggro = false

func _on_death_timer_timeout():
	queue_free()
