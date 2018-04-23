extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	update_crystals()
	update_health()

func update_health():
	var i = 1
	for n in $health.get_children():
		if i <= Stats.health:
			n.visible = true
		else: n.visible = false
		i += 1

func update_crystals():
	$Points.text = str(Stats.crystals)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func tutorial_1():
	$Tip1.popup()