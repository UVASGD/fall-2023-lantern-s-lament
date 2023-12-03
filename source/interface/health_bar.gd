extends TextureProgressBar
class_name HealthBar

@onready var player = get_parent().get_parent().get_parent().get_node("Player")

func _physics_process(_delta):
	max_value = player.max_hp
	value = player.cur_hp
