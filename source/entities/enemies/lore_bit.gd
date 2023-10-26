extends Area2D
@onready var player = get_tree().get_root().get_node("MainScene/Player") as Player
@onready var menu = get_tree().get_root().get_node("MainScene/Menu/SideMenu")
@onready var interact = menu.get_node("Interact")
@export var heal_amount := 10
var nearby = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func write(prop : String):
	interact.text = prop + "\n"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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

func _on_area_exited(area):
	nearby = false
