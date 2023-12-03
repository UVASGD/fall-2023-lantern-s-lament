extends StaticBody2D

@onready var sprite = $Area2D/Sprite2D
@onready var light = $Area2D/PointLight2D
@onready var timer = $Area2D/Timer
@onready var lit = false
@onready var player = get_parent().get_node("Player")
@onready var final_torch = get_parent().get_node("FinalTorch")
@onready var light_scale : float = 0.0
@onready var flicker_scale : float = 0.0

func _ready():
	z_index = 1
	add_to_group("torches")

func _physics_process(delta):
	if lit:
		var tween = create_tween()
		tween.tween_property(self, "light_scale", 10*flicker_scale, 0.4)
	light.texture_scale = light_scale

func _on_area_2d_area_entered(area):
	var is_player : bool = (area.get_parent() == player)
	var is_player_ghost : bool = !(area.get_parent().get("glow") == null)
	if !lit:
			if(is_player && player.light_dim == 0):
				lit = true
				timer.start()
			if(is_player_ghost):
				if(area.get_parent().glow == 1):
					lit = true
					timer.start()
					area.get_parent().cur_hp = 0

func are_lit():
	if !lit: final_torch.torches_lit = false

func _on_timer_timeout():
	if(sprite.frame == 4): sprite.frame = 1
	else: sprite.frame += 1
	flicker_scale = randf()*0.1+0.95
