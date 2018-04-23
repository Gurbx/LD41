extends StaticBody2D

var crystal_scene = preload("res://Scenes/Crystal.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func drop_crystals():
	randomize()
	for i in range (0,4):
		var crystal = crystal_scene.instance()
		get_parent().add_child(crystal)
		var crys_pos = global_position
		crys_pos.x = crys_pos.x + rand_range(-15, 15)
		crys_pos.y = crys_pos.y + rand_range(-15, 15)
		crystal.global_position = crys_pos


func _on_colision_body_entered(body):
	if body.name == "ball":
		if (body.damages_enemies):
			drop_crystals()
			queue_free()
