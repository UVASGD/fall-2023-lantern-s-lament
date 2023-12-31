extends StaticBody2D
@onready var player = get_parent().get_node("Player")
@export var heal_amount := 30
var num = 0

func _process(_delta):
	num += PI/64
	if num > 2*PI:
		num = 0
	position.y += sin(num)

func _on_area_2d_area_entered(_area):
	if player.cur_hp != player.max_hp:
		player.set_cur_hp(player.cur_hp + heal_amount)
		queue_free()
