extends Area2D

@onready var player = get_tree().get_root().get_node("MainScene/Player")
@onready var speed = 5
@onready var damage = 50
@onready var boost = 0

func _ready():
	pass

func _process(delta):
	var target_position = (player.global_position - global_position).normalized()
	#global_position += target_position * (speed + boost) 
	boost *= 0.95

func _on_area_entered(area):
	boost = -20
