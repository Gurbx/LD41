extends KinematicBody2D

signal died

var chasePlayer = false
var playing_aggro = false
var dead = false
var crystal_scene = preload("res://Scenes/Crystal.tscn")
var bullet_scene = preload("res://Scenes/Shot.tscn")
var player_body
var speed = 20
var health = 10

var can_shoot = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if (chasePlayer): handle_chase(delta)
	elif(!playing_aggro): $AnimatedSprite.play("default")

func handle_chase(delta):
	var player_position = player_body.get_global_position()
	var direction = (player_position - global_position).normalized()
	var motion = Vector2()
	#motion += direction * delta * speed
	#position += motion
	if (can_shoot):
		can_shoot = false
		$cooldown.start()
		$shootSound.play()
		var bullet = bullet_scene.instance()
		get_parent().add_child(bullet)
		var pos = global_position
		bullet.set_direction((player_position-global_position).normalized())
		bullet.global_position = pos
	
	#Anim
	if (!playing_aggro):
		if (direction.y < 0):
			$AnimatedSprite.play("turn_up")
		elif(direction.x < 0):
			$AnimatedSprite.play("turn_left")
		else:
			$AnimatedSprite.play("turn_right")

func hit_by_player(damage):
	health -= damage
	if (health <= 0): 
		#$death.play()
		$CollisionShape2D.visible = false
		emit_signal("died")
		$deathTimer.start()
		#$shadow.visible = false
		$AnimatedSprite.visible = false
		dead = true
		#$Hit.emitting = true
		#$Hit.restart()
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

func _on_deathTimer_timeout():
	queue_free()

func _on_cooldown_timeout():
	can_shoot = true
