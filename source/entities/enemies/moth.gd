extends EnemyBase

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var dir : Vector2 = Vector2.ZERO
@export var tetherCords : Vector2 = Vector2.ZERO
@export var range : float = 2000.0
@onready var randomCords : Vector2 = Vector2.ZERO
@onready var player_angle
@onready var num = 0.0

func _ready():
	speed = 100
	hitbox.damage = 15
	max_hp = 40
	nav_agent.target_position = player.global_position
	super._ready()

func _physics_process(delta):
	in_aim_area = enemy_in_area()
	target_pos = (player.global_position - global_position).normalized()
	#player_angle = atan2(-(global_position.y - player.global_position.y), global_position.x - player.global_position.x)
	#target_pos = Vector2(delta*cos(player_angle)-(0.5*sin(delta)+sin(player_angle)), delta*sin(player_angle)+(0.5*sin(delta)*cos(player_angle))).normalized()
	if in_aim_area: super.move(target_pos * speed)
	num += PI/64
	if num > 2*PI:
		num = 0
	super.move(Vector2(0, sin(num)) * 50)

func _on_timer_timeout():
	if(enemy_in_area()): 
		nav_agent.target_position = player.global_position
	elif(self.global_position.distance_to(tetherCords) >= range):
		nav_agent.target_position = tetherCords
	else:
		if(self.global_position.distance_to(randomCords) <= 100):
			randomCords = self.global_position + Vector2(400*(randf()-0.5), 400*(randf()-0.5))
		nav_agent.target_position = randomCords
