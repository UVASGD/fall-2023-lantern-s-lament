extends Area2D

@onready var final_torch = get_parent().get_node("FinalTorch");
@export var next_scene : String;

func _on_area_entered(area):
	if (area.is_in_group("player") && final_torch.lit):
		SceneTransition.change_scene(next_scene)
	pass # Replace with function body.
