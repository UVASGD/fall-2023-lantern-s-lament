extends EnemyBase

func _ready():
	speed = 100
	hitbox.damage = 15
	max_hp = 40
	super._ready()

func _physics_process(_delta):
	#super._physics_process(delta)
	in_aim_area = enemy_in_area()
	target_pos = (player.global_position - global_position).normalized()
	#global_position = get_global_mouse_position()
	if in_aim_area: super.move(target_pos * speed)
