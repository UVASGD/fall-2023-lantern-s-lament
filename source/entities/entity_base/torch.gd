extends Area2D

@onready var sprite = $Sprite2D
@onready var lit = false
@onready var torch = get_tree().get_root().get_node("MainScene/FinalTorch")

func _ready():
	z_index = 1

func _on_area_entered(_area):
	if !lit:
		lit = true
		sprite.frame += 1
		#torch.light()

func are_lit():
	if !lit: torch.torches_lit = false
