extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$score.text = "Crystals: " + str(Stats.crystals)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button_pressed():
	$select.play()
	get_tree().change_scene("res://Scenes/Menu.tscn")


func _on_Button_button_down():
	$select.play()


func _on_Button2_pressed():
	Stats.retry_level()
