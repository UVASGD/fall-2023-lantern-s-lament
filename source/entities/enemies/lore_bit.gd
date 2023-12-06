extends Area2D
@onready var player = get_parent().get_node("Player")
@onready var menu = get_parent().get_node("Menu/SideMenu")
@onready var pressx = menu.get_node("PressX")
@export var heal_amount := 10
@export var text : String
var nearby = false

func _input(event):
	if player.game_start && event.is_action_pressed("interact") && nearby:
		nearby = false
		menu.pop_up(text)

func _on_area_entered(_area):
	nearby = true
	pressx.modulate.a = 1 

func _on_area_exited(_area):
	nearby = false
	pressx.modulate.a = 0
