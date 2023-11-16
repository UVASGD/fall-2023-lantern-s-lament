extends ColorRect

@onready var player = get_tree().get_root().get_node("MainScene/Player")
@onready var label = $Label

func resume_game():
	if player.game_start:
		get_tree().paused = false
		self.queue_free()

func _input(event):
	if event.is_action_pressed("pause_menu"):
		resume_game()

func _on_button_pressed():
	resume_game()
