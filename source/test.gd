extends StaticBody2D

@onready var player = get_parent().get_parent().get_node("Player")

func _physics_process(delta):
	if(global_position.distance_to(player.global_position) > 2000):
		hide()
	else:
		show()
