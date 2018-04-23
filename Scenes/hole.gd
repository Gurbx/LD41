extends Area2D

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_hole_body_entered(body):
	if (body.get_name() == "ball"):
		if (body.can_enter_hole() == true):
			body.set_can_be_damaged(false)
			$EndTimer.start()
			$Effect.emitting = true
			$Effect.restart()
			body.hide()
			body.stop()
			$done.play()
			print("level done")


func _on_EndTimer_timeout():
	Stats.set_next_level()
