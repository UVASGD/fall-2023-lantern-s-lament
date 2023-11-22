extends EnemyBase

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _ready():
	speed = 100
	hitbox.damage = 15
	max_hp = 40
	nav_agent.target_position = player.global_position
	super._ready()

func _physics_process(delta):
	super._physics_process(delta)
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	in_aim_area = enemy_in_area()
	if in_aim_area: move(speed * dir)

func _on_timer_timeout():
	nav_agent.target_position = player.global_position
