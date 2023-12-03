extends ColorRect

@onready var player = get_tree().get_root().get_node("MainScene/Player")

@onready var property_label = $PropertyLabel
@onready var interact = $Interact
@onready var value_label = $ValueLabel
@onready var flame_animator = $FlameAnimator
@onready var flame_sprite = $Flame
@onready var lamp = $Lamp
@onready var game_over = $GameOver
@onready var black_out = $BlackOut
@onready var woosh = $AudioStreamPlayer2D

@onready var pause_menu : PackedScene = preload("res://source/interface/pause_menu.tscn")
@onready var lore_menu : PackedScene = preload("res://source/interface/lore_menu.tscn")
@onready var end_screen : PackedScene = preload("res://source/interface/end_screen.tscn")

@onready var angle = 0.0
@onready var swing_velocity = 0.2
@onready var swing_acceleration : float
@onready var swing_boost : float
@onready var pos_translation_lamp = Vector2.ZERO
@onready var pos_translation_flame = Vector2.ZERO

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

func _physics_process(delta):
	flame_animator.play("flame_animation")
	
	property_label.text = ""
	value_label.text = ""
	write("Lamp Oil", str(player.cur_hp) + " / " + str(player.max_hp))
	
	if(player.direction == Vector2.ZERO): swing_boost = 1.0
	else: swing_boost = 2.0
	swing_acceleration = -5.0 * angle * swing_boost
	swing_velocity += swing_acceleration * delta
	angle += swing_velocity * delta
	if(angle > PI/12): 
		angle = PI/12
		swing_acceleration = 0
	if(angle < PI/-12): 
		angle = PI/-12
		swing_acceleration = 0
	
#	var tween = create_tween()
#	tween.tween_property(self, "angle", player.direction.x * PI/12, 0.4)
	
	pos_translation_lamp = Vector2((-128*sin(angle)),(-128*sin(angle)*sin(angle/2)/sin((PI-angle)/2)))
	pos_translation_flame = Vector2(((192 - flame_sprite.global_position.y)*sin(angle)),((192 - flame_sprite.global_position.y)*sin(angle)*sin(angle/2)/sin((PI-angle)/2)))
	
	#flame_sprite.scale = Vector2(0.2*(100-player.cur_hp), 0.2*(100-player.cur_hp))
	#flame_sprite.global_position = Vector2((128 + (-3.5/95)*(100-500*flame_sprite.scale.x)), (320 + (46.0/95)*(100-500*flame_sprite.scale.y))) + pos_translation_flame
	
	flame_sprite.scale = Vector2(0.0015*player.cur_hp+0.1, 0.0015*player.cur_hp+0.1)
	flame_sprite.global_position = Vector2((128 + (-3.5/95)*(100-500*flame_sprite.scale.x)), (320 + (46.0/95)*(100-500*flame_sprite.scale.y))) + pos_translation_flame
	flame_sprite.rotation = angle
	
	lamp.global_position = Vector2(128, 320) + pos_translation_lamp
	lamp.rotation = angle
	
	if(flame_sprite.modulate == Color(255, 255, 255, 0)):
		var end_inst = end_screen.instantiate()
		add_child(end_inst)
		end_inst.global_position = self.global_position + Vector2(256, 0)
		end_inst.modulate.a = 0
		flame_sprite.modulate = Color(255, 255, 0, 0)
