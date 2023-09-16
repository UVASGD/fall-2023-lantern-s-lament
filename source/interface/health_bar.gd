extends TextureProgressBar
class_name HealthBar

@onready var towerhull = get_tree().get_root().get_node("MainScene/TowerHull")

func _physics_process(_delta):
	max_value = towerhull.max_hp
	value = towerhull.cur_hp
