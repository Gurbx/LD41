extends Node

var shots_fired

func _ready():
	if Stats.get_current_level() == 1:
		$UI.tutorial_1()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_ball_damage_taken():
	Stats.damage_taken()
	$UI.update_crystals()
	$UI.update_health()


func _on_ball_shot_fired():
	Stats.use_crystal()
	$UI.update_crystals()


func _on_ball_crystal_picked():
	$UI.update_crystals()


func _on_Key_collected():
	$walls/door.open()
