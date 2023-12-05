extends ColorRect

@onready var player = get_parent().get_parent().get_parent().get_node("Player")
@onready var label = $Label

func resume_game():
	if player.game_start:
		get_tree().paused = false
		self.queue_free()

func _input(event):
	if event.is_action_pressed("pause_menu"):
		resume_game()

func _on_resume_pressed():
	resume_game()

func _on_main_menu_pressed():
	get_tree().paused = false
	SceneTransition.change_scene("res://source/levels/main_menu.tscn")
	print("main menu")
