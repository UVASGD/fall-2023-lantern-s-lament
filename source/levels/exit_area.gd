extends Area2D

@onready var final_torch = get_parent().get_node("FinalTorch");
@export var next_scene : String;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	if (area.is_in_group("player") && final_torch.lit):
		SceneTransition.change_scene(next_scene)
	pass # Replace with function body.
