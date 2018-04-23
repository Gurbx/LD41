extends Area2D

export(int) var value = 5
var picked_up = false

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Crystal_body_entered(body):
	if (body.name == "ball" && !picked_up):
		Stats.add_crystal(value)
		body.pick_crystal()
		picked_up = true
		$Sprite.visible = false
		$remove_timer.start()
		$Pickup.emitting = true
		$Pickup.restart()
		$pickup.play()


func _on_remove_timer_timeout():
	queue_free()
