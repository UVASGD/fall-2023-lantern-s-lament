extends EnemyBase

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var dir : Vector2 = Vector2.ZERO
@export var tetherCords : Vector2 = Vector2.ZERO
@onready var range : float = 1000.0
@onready var randomCords : Vector2 = Vector2.ZERO
@onready var player_angle
@onready var num = 0.0
@onready var frame : int = 0
@onready var frame_x : int = 0
@onready var frame_y : int = 0
@onready var flap = $Flap

func _ready():
	speed = 100
	hitbox.damage = 15
	max_hp = 40
	nav_agent.target_position = player.global_position
	super._ready()

func _physics_process(_delta):
	in_aim_area = enemy_in_area()
	target_pos = (player.global_position - global_position).normalized()
	#player_angle = atan2(-(global_position.y - player.global_position.y), global_position.x - player.global_position.x)
	#target_pos = Vector2(delta*cos(player_angle)-(0.5*sin(delta)+sin(player_angle)), delta*sin(player_angle)+(0.5*sin(delta)*cos(player_angle))).normalized()
	dir = to_local(nav_agent.get_next_path_position()).normalized()
	super.move(dir * speed)
	num += PI/32
	if num > 2*PI:
		num = 0
	super.move(Vector2(0, sin(num)) * 50)
	if(abs(sin(num)) == 1 && in_aim_area): 
		flap.play()

	if(abs(sin(num)) == 1):
		if(dir.x > 0): frame_y = 0
		else: frame_y = 1
		if(enemy_in_area()): frame_x = 2
		else: frame_x = 0
		frame = frame_x + 4*frame_y
		if(sprite.frame % 2 == 0): frame += 1
		sprite.frame = frame

func _on_timer_timeout():
	if(enemy_in_area()):
		nav_agent.target_position = player.global_position
	elif(self.global_position.distance_to(tetherCords) >= range):
		nav_agent.target_position = tetherCords
	else:
		if(self.global_position.distance_to(randomCords) <= 100):
			randomCords = self.global_position + Vector2(400*(randf()-0.5), 400*(randf()-0.5))
		nav_agent.target_position = randomCords
		

func _on_animation_timer_timeout():
	pass
"""
	if(dir.x > 0): frame_y = 0
	else: frame_y = 1
	if(nav_agent.target_position == player.global_position): frame_x = 2
	else: frame_x = 0
	frame = frame_x + 4*frame_y
	if(sprite.frame % 2 == 0): frame += 1
	sprite.frame = frame
"""
