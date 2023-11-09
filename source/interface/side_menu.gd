extends ColorRect

@onready var player = get_tree().get_root().get_node("MainScene/Player")

@onready var property_label = $PropertyLabel
@onready var interact = $Interact
@onready var value_label = $ValueLabel
@onready var flame_animator = $FlameAnimator
@onready var flame_sprite = $Flame

@onready var pause_menu : PackedScene = preload("res://source/interface/pause_menu.tscn")
@onready var lore_menu : PackedScene = preload("res://source/interface/lore_menu.tscn")

func pause_game():
	get_tree().paused = true
	var pause_inst = pause_menu.instantiate()
	add_child(pause_inst)
	pause_inst.global_position = self.global_position + Vector2(256, 0)
	
func pop_up():
	get_tree().paused = true
	var lore_inst = lore_menu.instantiate()
	add_child(lore_inst)
	lore_inst.global_position = self.global_position + Vector2(256, 0)
	#lore_inst.scale = Vector2(100, 100)
	print("pop-up works")

func write(prop : String, val):
	val = str(val)
	property_label.text += prop + "\n"
	value_label.text += "[right]" + val + "[/right] \n"

func space(val):
	for n in range(val):
		property_label.text += "\n"
		value_label.text += "\n"

func _physics_process(_delta):
	flame_animator.play("flame_animation")
	
	property_label.text = ""
	value_label.text = ""
	write("Lamp Oil", str(player.cur_hp) + " / " + str(player.max_hp))
	
	flame_sprite.scale = Vector2(3.4 * (player.cur_hp / 100.0), 3.4 * (player.cur_hp / 100.0))
