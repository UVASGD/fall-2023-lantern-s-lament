extends Area2D
@onready var player = get_tree().get_root().get_node("MainScene/Player") as Player
@onready var menu = get_tree().get_root().get_node("MainScene/Menu/SideMenu")
@onready var interact = menu.get_node("Interact")
@export var heal_amount := 10
var nearby = false

func write(prop : String):
	interact.text = prop + "\n"

func _process(_delta):
	if nearby:
		interact.text = ""
		write("Press X to interact")
	else:
		write(" ")
		
func _input(event):
	if player.game_start && event.is_action_pressed("interact") && nearby:
		nearby = false
		menu.pop_up()

func _on_area_entered(_area):
	nearby = true

func _on_area_exited(_area):
	nearby = false
