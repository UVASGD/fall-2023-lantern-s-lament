extends EnemyBase

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var point_light = $PointLight2D

@onready var point_light_scale : float = 0.0 #the size of the point light
@onready var glow : float = 0.0

func _ready():
	speed = 100
	hitbox.damage = 15
	max_hp = 40
	nav_agent.target_position = player.global_position
	super._ready()

func _physics_process(delta):
	super._physics_process(delta)
	queue_redraw()
	
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	move(speed * dir)
	var distance_x : float = abs(player.global_position.x-global_position.x)
	var distance_y : float = abs(player.global_position.y-global_position.y)
	
	if (cur_hp > 0):
		if(distance_x < 700.0 || distance_y < 500.0):
			player.light_dim = 1
			glow = 1
		if(distance_x > 1050.0 || distance_y > 750.0):
			player.light_dim = 0
			glow = 0
	else:
		player.light_dim = 0
		glow = 0
	
	var tween = create_tween()
	tween.tween_property(self, "point_light_scale", glow, 0.4)
	
	point_light.global_position = global_position
	point_light.texture_scale = point_light_scale

func _on_timer_timeout():
	nav_agent.target_position = player.global_position
