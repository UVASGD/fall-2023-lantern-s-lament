extends EnemyBase

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var point_light = $PointLight2D
@onready var animation_tree = $AnimationTree

@onready var dir : Vector2 = Vector2.ZERO
@onready var point_light_scale : float = 0.0 #the size of the point light
@onready var glow : float = 0.0
@onready var transparency : float = 0.0
@onready var state_machine = animation_tree.get("parameters/playback")

@export var tetherCords : Vector2 = Vector2.ZERO
@export var range : float = 2000.0
@onready var randomCords : Vector2 = Vector2.ZERO

func _ready():
	speed = 100
	hitbox.damage = 15
	max_hp = 40
	nav_agent.target_position = player.global_position
	sprite.modulate = Color(1.33, 1.67, 2, 0)
	super._ready()
	self.scale = Vector2(1, 1)

func _physics_process(delta):
	queue_redraw()
	
	dir = to_local(nav_agent.get_next_path_position()).normalized()
	move(speed * dir)
	update_animation()
	
	var distance_x : float = abs(player.global_position.x-global_position.x)
	var distance_y : float = abs(player.global_position.y-global_position.y)
	
	if (cur_hp > 0):
		if(distance_x < 500.0 && distance_y < 500.0):
			player.light_dim = 1
			glow = 1
		if(distance_x > 1250.0 || distance_y > 950.0):
			player.light_dim = 0
			glow = 0
	else:
		player.light_dim = 0
		glow = 0
	
	var tween1 = create_tween()
	var tween2 = create_tween()
	tween1.tween_property(self, "point_light_scale", glow*2.4, 0.4)
	tween2.tween_property(self, "transparency", glow/2, 0.4)
	
	sprite.modulate = Color(1.33, 1.67, 2, transparency)
	point_light.global_position = global_position
	point_light.texture_scale = point_light_scale

func update_animation():
	if(dir != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", dir)
		animation_tree.set("parameters/Move/blend_position", dir)
		state_machine.travel("Move")
	else: state_machine.travel("Idle")

func _on_timer_timeout():
	if(self.global_position.distance_to(player.global_position) <= range): 
		nav_agent.target_position = player.global_position
	elif(self.global_position.distance_to(tetherCords) >= range):
		nav_agent.target_position = tetherCords
	else:
		if(self.global_position.distance_to(randomCords) <= 100):
			randomCords = self.global_position + Vector2(400*(randf()-0.5), 400*(randf()-0.5))
		nav_agent.target_position = randomCords
