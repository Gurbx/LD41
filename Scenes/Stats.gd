extends Node

var START_HEALTH = 5
var health
var crystals = 0
var current_level
const LEVELS = 5

func _ready():
	init()

func init():
	current_level = 1
	reset_items()

func reset_items():
	crystals = 0
	health = START_HEALTH

func damage_taken():
	health -= 1
	crystals -= 5
	if (health <= 0): game_over()
	if (crystals <= 0):
		crystals = 0

func use_crystal():
	crystals -= 1
	if (crystals <= 0):
		crystals = 0

func add_crystal(nr):
	crystals += nr

func set_next_level():
	if (current_level > LEVELS): 
		#goto_scene("res://Menu.tscn")
		get_tree().change_scene("res://Scenes/Win.tscn")
	get_tree().change_scene("res://Scenes/level" + str(current_level) +".tscn")
	#goto_scene("res://level" + str(current_level) +".tscn")
	
	current_level += 1

func game_over():
	get_tree().change_scene("res://Scenes/GameOver.tscn")

func get_current_level():
	return current_level-1

func retry_level():
	current_level -= 1
	reset_items()
	set_next_level()

    #current_scene.queue_free() # get rid of the old scene

    # start your "loading..." animation
    #get_node("animation").play("loading")

   # wait_frames = 1