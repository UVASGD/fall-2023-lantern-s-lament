extends Area2D
@onready var player = get_tree().get_root().get_node("MainScene/Player") as Player
@export var heal_amount := 10
var num = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	num += PI/64
	if num > 2*PI:
		num = 0
	position.y += sin(num)


func _on_area_entered(_area):
	if player.cur_hp != player.max_hp:
		player.set_cur_hp(player.cur_hp + heal_amount)
		queue_free()
