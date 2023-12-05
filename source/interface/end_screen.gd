extends ColorRect

#@onready var player = get_tree().get_root().get_node("MainScene/Player")
#@onready var side_menu = get_tree().get_root().get_node("MainScene/Menu/SideMenu")
@onready var opacity: float = -0.25

func _physics_process(_delta):
	if (opacity < 1):
		opacity += 0.01
		if (opacity > 0): modulate.a = opacity

func _on_restart_pressed():
	get_tree().paused = false
	SceneTransition.change_scene("res://source/levels/level_1.tscn") #change when adding levels
	print("restart")
	
func _on_main_menu_pressed():
	get_tree().paused = false
	SceneTransition.change_scene("res://source/levels/main_menu.tscn")
	print("main menu")
