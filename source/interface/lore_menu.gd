extends ColorRect

@onready var player = get_tree().get_root().get_node("MainScene/Player")
@onready var label = $Label
@onready var loreBit = get_tree().get_root().get_node("MainScene/LoreBit")
@onready var label_text : String

func _ready():
	label.text = label_text
#	if (label.text == "I've got a bag of... uh... hamburgers for you. All you have to do is to come out into the dark shadowy part of the woods, where no one can see you."):
#		label.font = false

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

func set_text(text):
	if (label == null):
		label_text = text
	else:
		label.text = text
		if (label.text == "I've got a bag of... uh... hamburgers for you. All you have to do is to come out into the dark shadowy part of the woods, where no one can see you."):
			label.font = null
	
