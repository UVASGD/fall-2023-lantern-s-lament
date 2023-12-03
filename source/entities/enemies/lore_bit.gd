extends Area2D
@onready var player = get_tree().get_root().get_node("MainScene/Player") as Player
@onready var menu = get_tree().get_root().get_node("MainScene/Menu/SideMenu")
@onready var pressx = menu.get_node("PressX")
@export var heal_amount := 10
var nearby = false

func _process(_delta):
	if nearby: pressx.modulate.a = 1
	else: pressx.modulate.a = 0
		
func _input(event):
	if player.game_start && event.is_action_pressed("interact") && nearby:
		nearby = false
		menu.pop_up()

func _on_area_entered(_area):
	nearby = true

func _on_area_exited(_area):
	nearby = false
