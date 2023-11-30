extends StaticBody2D

@onready var sprite = $Area2D/Sprite2D
@onready var lit = false
@onready var torch = get_tree().get_root().get_node("MainScene/FinalTorch")

@onready var animation_offset = 0

func _ready():
	z_index = 1
	
func _physics_process(_delta):
	if lit:
		animation_offset += 1
		if animation_offset >= 10:
			if sprite.frame >= 4: sprite.frame = 2
			else: sprite.frame += 1
			animation_offset = 0

func _on_area_2d_area_entered(area):
	if !lit:
		lit = true
		sprite.frame += 1

func are_lit():
	if !lit: torch.torches_lit = false
