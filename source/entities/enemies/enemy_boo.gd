extends EnemyBase

#@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
# const SPEED = 300.0
func _ready():
	speed = 50
	hitbox.damage = 15
	max_hp = 40
	#nav_agent.target_position = player.global_position
	super._ready()

func _physics_process(delta):
	super._physics_process(delta)
	
	# direction = sprite.frame -> 0-3 is down, 4-7 is right?, 8-11 is up, 12-15 is left
	var player_frame = player.sprite.frame
	var is_seen = false
	var relative_dir = global_position.direction_to(player.global_position)
	if (player_frame >= 0 && player_frame <= 3):
		if (-relative_dir.y >= sqrt(1.0/2)):
			is_seen = true
	if (player_frame >= 4 && player_frame <= 7):
		if (-relative_dir.x >= sqrt(1.0/2)):
			is_seen = true
	if (player_frame >= 8 && player_frame <= 11):
		if (relative_dir.y >= sqrt(1.0/2)):
			is_seen = true
	if (player_frame >= 12 && player_frame <= 15):
		if (relative_dir.x >= sqrt(1.0/2)):
			is_seen = true
	
	#var dir = to_local(nav_agent.get_next_path_position()).normalized()
	if (!is_seen):
		move(speed * relative_dir)
	
#func _on_timer_timeout():
#	nav_agent.target_position = player.global_position
