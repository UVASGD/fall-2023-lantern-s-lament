extends EnemyBase

@onready var player_angle

func _ready():
	speed = 100
	hitbox.damage = 15
	max_hp = 40
	super._ready()

func _physics_process(delta):
	in_aim_area = enemy_in_area()
	target_pos = (player.global_position - global_position).normalized()
	#player_angle = atan2(-(global_position.y - player.global_position.y), global_position.x - player.global_position.x)
	#target_pos = Vector2(delta*cos(player_angle)-(0.5*sin(delta)+sin(player_angle)), delta*sin(player_angle)+(0.5*sin(delta)*cos(player_angle))).normalized()
	if in_aim_area: super.move(target_pos * speed)
	super.move(Vector2(0, sin(delta)) * 1000)
	print(delta)
