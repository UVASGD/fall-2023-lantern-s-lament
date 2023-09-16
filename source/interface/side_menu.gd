extends ColorRect

@onready var towerhull = get_tree().get_root().get_node("MainScene/TowerHull")

@onready var property_label = $PropertyLabel
@onready var value_label = $ValueLabel
@onready var flame_animator = $FlameAnimator
@onready var flame_sprite = $Flame

@onready var pause_menu : PackedScene = preload("res://source/interface/pause_menu.tscn")

func pause_game():
	get_tree().paused = true
	var pause_inst = pause_menu.instantiate()
	add_child(pause_inst)
	pause_inst.global_position = self.global_position + Vector2(256, 0)

func write(prop : String, val):
	val = str(val)
	property_label.text += prop + "\n"
	value_label.text += "[right]" + val + "[/right] \n"

func space(val):
	for n in range(val):
		property_label.text += "\n"
		value_label.text += "\n"

func _physics_process(delta):
	flame_animator.play("flame_animation")
	
	property_label.text = ""
	value_label.text = ""
	write("Lamp Oil", str(towerhull.cur_hp) + " / " + str(towerhull.max_hp))
	
	flame_sprite.scale = Vector2(3.4 * (towerhull.cur_hp / 100.0), 3.4 * (towerhull.cur_hp / 100.0))
