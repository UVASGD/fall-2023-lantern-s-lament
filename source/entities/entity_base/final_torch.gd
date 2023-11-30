extends Area2D

@onready var sprite = $Sprite2D
@onready var light = $PointLight2D
@onready var timer = $Timer
@onready var lit = false
@onready var torches_lit = false
@onready var player = get_parent().get_node("Player")
@onready var light_scale : float = 0.0
@onready var flicker_scale : float = 0.0

@onready var monster : PackedScene = preload("res://source/entities/enemies/eol_monster.tscn")

func _physics_process(delta):
	if lit:
		var tween = create_tween()
		tween.tween_property(self, "light_scale", 12*flicker_scale, 0.4)
	light.texture_scale = light_scale

func _on_area_entered(area):
	var is_player : bool = (area.get_parent() == player)
	var is_player_ghost : bool = !(area.get_parent().get("glow") == null)
	
	if !lit:
		if(is_player && player.light_dim == 0): 
			torches_lit = true
		if(is_player_ghost):
			if(area.get_parent().glow == 1):
				torches_lit = true
		
		get_tree().call_group("torches", "are_lit")
		if torches_lit:
			lit = true
			timer.start()
			if(is_player_ghost):
				area.get_parent().cur_hp = 0
			
			var monster_inst = monster.instantiate()
			get_tree().current_scene.call_deferred("add_child", monster_inst)
			monster_inst.scale = Vector2(15, 15)
			monster_inst.global_position = self.global_position - 2*player.speed

func _on_timer_timeout():
	if(sprite.frame == 4): sprite.frame = 1
	else: sprite.frame += 1
	flicker_scale = randf()*0.1+0.95

"""
func light():
	#torches_lit += 1
	pass
"""
