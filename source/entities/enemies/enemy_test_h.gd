extends EnemyBase

func _ready():
	speed = 10
	hitbox.damage = 15
	max_hp = 40
	super._ready()

func _physics_process(delta):
	super._physics_process(delta)
	target_pos = (player.global_position - global_position).normalized()
	#global_position = get_global_mouse_position()
	super.move(target_pos * speed)
	var distance : float = sqrt(pow(player.global_position.x-global_position.x, 2)+pow(player.global_position.y-global_position.y, 2))
	if (cur_hp != 0 && distance < 1000.0):
		player.light_inhibited = true
