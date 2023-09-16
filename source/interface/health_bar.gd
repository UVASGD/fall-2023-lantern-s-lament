extends TextureProgressBar
class_name HealthBar

@onready var player = get_tree().get_root().get_node("MainScene/Player")

func _physics_process(_delta):
	max_value = player.max_hp
	value = player.cur_hp
