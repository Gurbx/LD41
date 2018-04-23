extends Area2D

export (int) var damage
export(int) var speed

var direction = Vector2(0,0)

func _ready():
	pass

func _process(delta):
	var motion = Vector2()
	motion += direction * delta * speed
	position += motion


func _on_projectile_body_entered(body):
	if body.has_method("hit_by_player"):
		body.call("hit_by_player", damage)
	queue_free()
	

func set_target(new_direction):
	direction = new_direction.normalized()

func _on_lifetime_timeout():
	queue_free()
