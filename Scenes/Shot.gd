extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var direction = Vector2(0,0)
var speed = 120
var alive = true

func _ready():
	pass

func set_direction(dir):
	direction = dir

func _process(delta):
	position += direction * speed * delta

func _on_Shot_body_entered(body):
	if body.name == "ball" && alive:
		alive = false
		$Particles.emitting = false
		$Explosion.emitting = true
		$Explosion.restart()
		$Sprite.hide()
		body.damage()


func _on_LifeTime_timeout():
	queue_free()
