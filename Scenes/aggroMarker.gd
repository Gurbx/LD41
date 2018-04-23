extends Area2D

signal player_in_range
signal player_out_of_range

func _on_aggroMarker_body_entered(body):
	if (body.get_name() == "ball"):
		print("player in range")
		emit_signal("player_in_range", body)

func _on_aggroMarker_body_exited(body):
	if (body.get_name() == "ball"):
		print("player out of range")
		emit_signal("player_out_of_range")
