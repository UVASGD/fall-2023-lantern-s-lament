extends Control

@onready var torch = get_parent().get_node("torch")
@onready var flame = get_parent().get_node("Flame")
@onready var delay = 0

func _physics_process(_delta):
	delay += 1
	if(delay == 10):
		if(torch.frame < 4): torch.frame += 1
		else: torch.frame = 2
		delay = 0

func _on_play_pressed():
	SceneTransition.change_scene("res://source/levels/level_1.tscn")

func _on_settings_pressed():
	SceneTransition.change_scene("res://source/levels/settings_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()


func _on_flame_finished():
	flame.play()
