extends ColorRect

@onready var player = get_tree().get_root().get_node("MainScene/Player")
@onready var label = $Label
@onready var loreBit = get_tree().get_root().get_node("MainScene/LoreBit")

func resume_game():
	if player.game_start:
		await get_tree().create_timer(0.1).timeout
		loreBit.nearby = true
		get_tree().paused = false
		self.queue_free()

func _input(event):
	if event.is_action_pressed("interact"):
		resume_game()

func _on_button_pressed():
	resume_game()
