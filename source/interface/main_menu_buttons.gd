extends Control

func _on_play_pressed():
	SceneTransition.change_scene("res://source/levels/main_scene.tscn")

func _on_settings_pressed():
	SceneTransition.change_scene("res://source/levels/settings_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
