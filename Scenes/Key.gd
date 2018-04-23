extends Area2D

signal collected
var alive = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Key_body_entered(body):
	if (body.name == "ball") && alive:
		alive = false
		emit_signal("collected")
		$pickup.emitting = true
		$particles.emitting = false
		$pickup.restart()
		$Timer.start()
		$Sprite.visible = false
		$sound.play()


func _on_Timer_timeout():
	queue_free()
