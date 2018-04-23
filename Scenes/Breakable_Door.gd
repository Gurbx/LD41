extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _break():
	$Timer.start()
	$effect.emitting = true
	$effect.restart()
	$sound.play()
	if ($Sprite != null): $Sprite.visible = false
	if ($Sprite2 != null): $Sprite2.visible = false

func _on_Timer_timeout():
	queue_free()
