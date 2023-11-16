extends Area2D

@onready var sprite = $Sprite2D
@onready var lit = false
@onready var torch = get_tree().get_root().get_node("MainScene/FinalTorch")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_entered(_area):
	if !lit:
		lit = true
		sprite.frame += 1
		#torch.light()

func are_lit():
	if !lit: torch.torches_lit = false
