extends EnemyBase

func _ready():
	speed = 100
	hitbox.damage = 15
	max_hp = 40
	super._ready()

func _physics_process(delta):
	super._physics_process(delta)
	target_pos = (towerhull.global_position - global_position).normalized()
	#global_position = get_global_mouse_position()
	super.move(target_pos * speed)
